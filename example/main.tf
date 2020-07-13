module "external" {
  source = "../"

  dns          = "example.com"
  txt_owner_id = "dns-private" //optional
  dns_provider = "google"
}