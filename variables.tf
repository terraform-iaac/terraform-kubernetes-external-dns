locals {
  aws_zone_type = var.aws_zone_type == null ? [] : ["--aws-zone-type=${var.aws_zone_type}"]
  args = concat([
    "--source=service",
    "--source=ingress",
    "--provider=${var.dns_provider}",
    "--policy=${var.policy}",
    "--registry=txt",
    "--txt-owner-id=${var.txt_owner_id}"
  ], local.aws_zone_type, formatlist("--domain-filter=%s", var.dns), var.additional_args)
}

variable "name" {
  type        = string
  description = "(Optional) Global name for resources"
  default     = "external-dns"
}
variable "service_account_annotations" {
  default = null
}
variable "aws_zone_type" {
  type        = string
  description = "(Optional) Only look at public hosted zones (valid values are public, private or no value for both)"
  default     = null
}
variable "create_namespace" {
  type        = bool
  description = "(Optional) Create namespace?"
  default     = true
}
variable "namespace" {
  type        = string
  description = "(Optional) Namespace name"
  default     = "external-dns"
}
variable "dns" {
  type        = list(string)
  description = "(Required) List of DNS names: exmaple.com, test.com"
}
variable "txt_owner_id" {
  type        = string
  description = "(Optional) TXT Owner"
  default     = "external-dns"
}
variable "namespace_labels" {
  description = "(Optional) Add namespace labels"
  default     = {}
}
variable "image" {
  description = "(Optional) Docker image"
  type        = string
  default     = "bitnami/external-dns"
}
variable "image_tag" {
  description = "(Optional) Docker image tag"
  type        = string
  default     = "0.7.4"
}
variable "custom_args" {
  description = "(Optional) Replace default args"
  type        = list(string)
  default     = []
}
variable "additional_args" {
  description = "(Optional) Add extra args to exist"
  type        = list(string)
  default     = []
}
variable "policy" {
  description = "(Optional) Would prevent ExternalDNS from deleting any records, omit to enable full synchronization"
  default     = "upsert-only"
}
variable "dns_provider" {
  description = "(Required) DNS Provider"
  type        = string
}
variable "node_selector" {
  description = "(Optional) Specify node selector for pod"
  type        = map(string)
  default     = null
}
variable "env" {
  type        = list(object({ name = string, value = string }))
  description = "(Optional) Add environment variables to pods."
  default     = []
}
variable "security_context" {
  description = "Secuity context for deployment"
  default      = null
}