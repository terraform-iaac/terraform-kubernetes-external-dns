locals {
  aws_zone_type = var.aws_zone_type == null ? [] : ["--aws-zone-type=${var.aws_zone_type}"]
  args          = concat ([
    "--source=service",
    "--source=ingress",
    "--domain-filter=${var.dns}",
    "--provider=${var.dns_provider}",
    "--policy=${var.policy}",
    "--registry=txt",
    "--txt-owner-id=${var.txt_owner_id}"
  ], local.aws_zone_type)
}

variable "name" {
  type = string
  description = "(Optional) Global name for resources"
  default     = "external-dns"
}
variable "aws_zone_type" {
  type = string
  description = "(Optional) Only look at public hosted zones (valid values are public, private or no value for both)"
  default     = null
}
variable "create_namespace" {
  type = bool
  description = "(Optional) Create namespace?"
  default     = true
}
variable "namespace" {
  type = string
  description = "(Optional) Namespace name"
  default     = "external-dns"
}
variable "dns" {
  type        = string
  description = "(Required) DNS name: exmaple.com"
}
variable "service_type_ip" {
  type        = string
  description = "(Optional) Which ips resolves for services. public or private"
  default     = "private"
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
variable "whitelist_annotation" {
  type        = string
  description = "(Optional) Annotations in yaml for external dns. External dns updates resource with this annotation"
  default     = "external-dns=use"
}
variable "image" {
  description = "(Optional) Docker image"
  type        = string
  default     = "bitnami/external-dns"
}
variable "image_tag" {
  description = "(Optional) Docker image tag"
  type        = string
  default     = "0.7.2"
}
variable "custom_args" {
  description = "(Optional) Replace default args"
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