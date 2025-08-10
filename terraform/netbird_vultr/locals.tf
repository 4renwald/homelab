locals {
  userdata = templatefile("${path.module}/templates/userdata.sh.tmpl", {
    domain_name = var.domain_name
    subdomain_name = var.subdomain_name
  })

  tcp_ports = toset([
    "80",
    "443",
    "33073",
    "10000",
    "33080"
  ])

  udp_ports = toset([
    "3478",
    "49152-65535",
  ])

  cloudflare_zone_id   = data.cloudflare_zone.dns_zone.zone_id
  cloudflare_zone_name = data.cloudflare_zone.dns_zone.name
  netbird_instance_ip  = vultr_instance.netbird.main_ip
}
