variable "dns" {
  type        = list(string)
  description = "(Required) List of DNS zones: exmaple.com, test.com"
}
variable "dns_provider" {
  description = "(Required) DNS Provider"
  type        = string
}
variable "policy" {
  description = "(Optional) Would prevent ExternalDNS from deleting any records, omit to enable full synchronization"
  default     = "upsert-only"
}
variable "aws_zone_type" {
  type        = string
  description = "(Optional) Type for hosted zones (valid values are public, private or no value for both)"
  default     = null
}
variable "txt_owner_id" {
  type        = string
  description = "(Optional) TXT Owner"
  default     = "external-dns"
}
variable "name" {
  type        = string
  description = "(Optional) Global name for resources. Used as a prefix"
  default     = "external-dns"
}
variable "namespace" {
  type        = string
  description = "(Optional) Namespace name"
  default     = "external-dns"
}
variable "create_namespace" {
  type        = bool
  description = "(Optional) Create namespace?"
  default     = true
}
variable "namespace_labels" {
  description = "(Optional) Add namespace labels"
  default     = {}
}
variable "service_account_annotations" {
  description = "Annotation for external-dns Service Account"
  default     = null
}
variable "image" {
  description = "(Optional) Docker image"
  type        = string
  default     = "bitnami/external-dns"
}
variable "image_tag" {
  description = "(Optional) Docker image tag"
  type        = string
  default     = "0.9.0"
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
variable "env" {
  type        = list(object({ name = string, value = string }))
  description = "(Optional) Add environment variables to pods."
  default     = []
}
variable "node_selector" {
  description = "(Optional) Specify node selector for pod"
  type        = map(string)
  default     = null
}
variable "security_context" {
  description = "Secuity context for deployment"
  default     = []
}