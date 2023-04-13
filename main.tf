resource "kubernetes_namespace" "namespace" {
  count = var.create_namespace ? 1 : 0

  metadata {
    annotations = {
      name = var.namespace
    }
    labels = var.namespace_labels
    name   = var.namespace
  }
}
resource "kubernetes_service_account" "exeternal-dns-user" {
  metadata {
    name        = var.name
    namespace   = var.create_namespace ? kubernetes_namespace.namespace.0.metadata.0.name : var.namespace
    annotations = var.service_account_annotations
  }

  automount_service_account_token = true
}

resource "kubernetes_cluster_role" "external-dns-role" {
  metadata {
    name = var.name
  }
  rule {
    api_groups = ["extensions", "networking.k8s.io"]
    resources  = ["ingresses"]
    verbs      = ["get", "watch", "list"]
  }
  rule {
    api_groups = [""]
    resources  = ["services", "endpoints", "pods"]
    verbs      = ["get", "watch", "list"]
  }
  rule {
    api_groups = [""]
    resources  = ["nodes"]
    verbs      = ["list"]
  }
}

resource "kubernetes_cluster_role_binding" "external-dns-binding" {
  metadata {
    name = "${var.name}-viewer"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_service_account.exeternal-dns-user.metadata[0].name
  }
  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.exeternal-dns-user.metadata[0].name
    namespace = var.create_namespace ? kubernetes_namespace.namespace.0.metadata.0.name : var.namespace
  }
}

module "deployment" {
  source  = "terraform-iaac/deployment/kubernetes"
  version = "1.1.3"

  name                  = var.name
  namespace             = var.create_namespace ? kubernetes_namespace.namespace.0.metadata.0.name : var.namespace
  image                 = "${var.image}:${var.image_tag}"
  service_account_token = true
  service_account_name  = kubernetes_service_account.exeternal-dns-user.metadata[0].name
  args                  = length(var.custom_args) == 0 ? local.args : var.custom_args
  node_selector         = var.node_selector
  env                   = var.env
  security_context      = var.security_context
  resources             = var.resources
}