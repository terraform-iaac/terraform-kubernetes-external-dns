resource "kubernetes_namespace" "namespace" {
  metadata {
    annotations = {
      name = local.name
    }
    labels = var.namespace_labels
    name = local.name
  }
}

resource "kubernetes_service_account" "exeternal-dns-user" {
  metadata {
    name = local.name
    namespace = kubernetes_namespace.namespace.id
  }
  automount_service_account_token = true
}

resource "kubernetes_secret" "external-dns-user-secret" {
  metadata {
    name = local.name
    namespace = kubernetes_namespace.namespace.id
  }
}

resource "kubernetes_cluster_role" "external-dns-role" {
  metadata {
    name = local.name
  }
  rule {
    api_groups = [""]
    resources = ["services","endpoints","pods"]
    verbs = ["get", "watch", "list"]
  }
  rule {
    api_groups = [""]
    resources = ["nodes"]
    verbs = ["get", "watch", "list"]
  }
  rule {
    api_groups = ["extensions"]
    resources = ["ingresses"]
    verbs = ["get", "watch", "list"]
  }
}

resource "kubernetes_cluster_role_binding" "external-dns-binding" {
  metadata {
    name = "${local.name}-viewer"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind = "ClusterRole"
    name = kubernetes_service_account.exeternal-dns-user.metadata[0].name
  }
  subject {
    kind = "ServiceAccount"
    name = kubernetes_service_account.exeternal-dns-user.metadata[0].name
    namespace = kubernetes_namespace.namespace.id
  }
}

resource "kubernetes_deployment" "external-dns-deploy" {
  metadata {
    name = local.name
    namespace = kubernetes_namespace.namespace.id
    labels = {
      app = local.name
    }
  }
  spec {
    selector {
      match_labels = {
        app = local.name
      }
    }
    strategy {
      type = "Recreate"
    }
    template {
      metadata {
        labels = {
          app = local.name
        }
      }
      spec {
        automount_service_account_token = true
        service_account_name = kubernetes_service_account.exeternal-dns-user.metadata[0].name
        container {
          name = local.name
          image = "cmaster11/external-dns:filter-private-public-service-ip-v0.5.9"
          args = [
            "--source=service",
            "--source=ingress",
            "--domain-filter=${var.dns}",
            "--provider=google",
            "--policy=upsert-only",
            "--registry=txt",
            "--service-publish-ips-type=${var.service_type_ip}",
            "--txt-owner-id=${var.txt_owner_id}"
          ]
        }
      }
    }
  }
}