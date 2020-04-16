locals {
  name = "external-dns"
}
variable "dns" {
  description = "(Required) DNS name: exmaple.com"
}
variable "service_type_ip" {
  description = "(Optional) Which ips resolves for services. public or private"
  default = "private"
}
variable "txt_owner_id" {
  description = "(Optional) TXT Owner"
  default = "external-dns"
}
variable "namespace_labels" {
  description = "(Optional) Add namespace labels"
  default = {}
}