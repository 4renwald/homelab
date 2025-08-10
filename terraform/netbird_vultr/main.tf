data "cloudflare_zone" "dns_zone" {
  filter = {
    name = var.domain_name
  }
}

resource "vultr_instance" "netbird" {
    plan                = var.plan
    region              = var.region
    os_id               = var.os_id
    label               = var.label
    hostname            = var.hostname
    enable_ipv6         = false
    disable_public_ipv4 = false
    ddos_protection     = false
    activation_email    = var.activation_email
    ssh_key_ids         = var.ssh_key_ids
    user_scheme         = var.user_scheme
    backups             = var.backups
    firewall_group_id   = vultr_firewall_group.netbird_firewall.id

    user_data = local.userdata
}

resource "vultr_firewall_group" "netbird_firewall" {
  description = "NetBird base firewall"
}

resource "vultr_firewall_rule" "netbird_firewallrule_tcp_v4" {
  for_each          = local.tcp_ports
  firewall_group_id = vultr_firewall_group.netbird_firewall.id
  protocol          = "tcp"
  ip_type           = "v4"
  subnet            = "0.0.0.0"
  subnet_size       = 0
  port              = each.value
  notes             = "allow tcp ${each.value}"
}

resource "vultr_firewall_rule" "netbird_firewallrule_udp_v4" {
  for_each          = local.udp_ports
  firewall_group_id = vultr_firewall_group.netbird_firewall.id
  protocol          = "udp"
  ip_type           = "v4"
  subnet            = "0.0.0.0"
  subnet_size       = 0
  port              = each.value
  notes             = "allow udp ${each.value}"
}

resource "vultr_firewall_rule" "netbird_firewallrule_ssh" {
  firewall_group_id = vultr_firewall_group.netbird_firewall.id
  protocol          = "tcp"
  ip_type           = "v4"
  subnet            = var.ssh_allowed_ip
  subnet_size       = 32
  port              = 22
  notes             = "allow tcp ssh"
}

resource "cloudflare_dns_record" "netbird_dns_record" {
  zone_id = local.cloudflare_zone_id
  name = var.subdomain_name
  ttl = 1
  type = "A"
  comment = "NetBird record"
  content = local.netbird_instance_ip
  proxied = true
}