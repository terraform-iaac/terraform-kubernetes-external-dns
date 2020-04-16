module "external" {
  source = "../"
  dns = "example.com"
  service_type_ip = "private" // optional default private
  txt_owner_id = "dns-private" //optional
}