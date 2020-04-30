locals {
  name = "external-dns"
}
variable "dns" {
  type = string
  description = "(Required) DNS name: exmaple.com"
}
variable "service_type_ip" {
  type = string
  description = "(Optional) Which ips resolves for services. public or private"
  default = "private"
}
variable "txt_owner_id" {
  type = string
  description = "(Optional) TXT Owner"
  default = "external-dns"
}
variable "namespace_labels" {
  description = "(Optional) Add namespace labels"
  default = {}
}
variable "whitelist_annotation" {
  type = string
  description = "(Optional) Annotations in yaml for external dns. External dns updates resource with this annotation"
  default = "external-dns=use"
}