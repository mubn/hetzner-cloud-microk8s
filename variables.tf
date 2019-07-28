# Set the variable value in *.tfvars file
# or using the -var="hcloud_token=..." CLI option
variable "hcloud_token" {
  type        = "string"
  description = "Hetzner Cloud project token"
}

variable "hcloud_ssh_key" {
  type        = "string"
  description = "Hetzner Cloud ssh key to be used"
  default     = "dell"
}

variable "hcloud_image" {
  type        = "string"
  description = "Hetzner Cloud image name"
  default     = "ubuntu-18.04"
}

variable "hcloud_custom_image" {
  type        = "string"
  description = "Hetzner Cloud custom image with all dependencies installed"
  default     = "false"
}

variable "hcloud_server_type" {
  type        = "string"
  description = "Hetzner Cloud server type"
  default     = "cx21"
}

variable "hcloud_key_path" {
  type        = "string"
  description = "Local path to ssh key"
  default     = "~/.ssh/id_rsa"
}
