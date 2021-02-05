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