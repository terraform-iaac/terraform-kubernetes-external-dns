output "service_account_name" {
  value = kubernetes_service_account.exeternal-dns-user.id
}
output "namespace" {
  value = var.create_namespace ? kubernetes_namespace.namespace.0.metadata.0.name : var.namespace
}