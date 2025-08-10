output "netbird_instance_ip" {
  description = "Public IPv4 address of the NetBird instance."
  value       = local.netbird_instance_ip
}

output "netbird_instance_password" {
  description = "Default root password from Vultr."
  value       = nonsensitive(vultr_instance.netbird.default_password)
}
