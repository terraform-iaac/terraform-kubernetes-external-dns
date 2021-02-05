module "external_dns" {
  source  = "terraform-iaac/external-dns/kubernetes"
  version = "1.1.10"

  dns           = ["example.com", "another.com", "dev.support.com"]
  dns_provider  = "aws"
  aws_zone_type = "public"
}