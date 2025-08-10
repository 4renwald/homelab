variable "vultr_api_key" {
  type        = string
  description = "API key used to deploy Vultr resources."
  sensitive   = true
}

variable "cloudflare_api_token" {
  type        = string
  description = "API key used to add Cloudflare DNS record."
  sensitive   = true
}

variable "ssh_key_ids" {
  type        = list(string)
  description = "A list of SSH key IDs to apply to the server on install (only valid for Linux/FreeBSD)."
}

variable "hostname" {
  type        = string
  description = "Hostname of the NetBird instance running in Vultr."
}

variable "label" {
  type        = string
  description = "Label to assign to the Vultr instance."
}

variable "backups" {
  type        = string
  description = "Enabled backups of instance."
  default     = "disabled"
}

variable "region" {
  type        = string
  description = "Vultr region code where the instance will be deployed."
}

variable "activation_email" {
  type        = bool
  description = "Whether to send the Vultr activation email."
  default     = false
}

variable "plan" {
  type        = string
  description = "Vultr plan ID for the instance size."
  default     = "vc2-1c-2gb"
}

variable "os_id" {
  type        = number
  description = "Vultr OS ID for the instance."
  default     = 2571
}

variable "user_scheme" {
  type        = string
  description = "The scheme used for the default user."
  default     = "limited"
}

variable "domain_name" {
  type        = string
  description = "NetBird domain name."
}

variable "subdomain_name" {
  type        = string
  description = "NetBird subdomain name."
}

variable "ssh_allowed_ip" {
  type        = string
  description = "IP address allowed to SSH into the instance."
}