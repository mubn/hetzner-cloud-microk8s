# Configure the Hetzner Cloud Provider
provider "hcloud" {
  token = var.hcloud_token
}

# Create a server
resource "hcloud_server" "kubernetes" {
  name        = "kubernetes"
  image       = var.hcloud_image
  server_type = var.hcloud_server_type
  ssh_keys    = [var.hcloud_ssh_key]

  connection {
    host        = hcloud_server.kubernetes.ipv4_address
    type        = "ssh"
    user        = "root"
    private_key = file(var.hcloud_key_path)
    timeout     = "3m"
  }

  provisioner "file" {
    source      = "script.sh"
    destination = "/tmp/script.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "/tmp/script.sh ${var.hcloud_custom_image}",
    ]
  }

  provisioner "local-exec" {
    command = "ansible-playbook -u root --private-key ${var.hcloud_key_path} playbook.yml -i ${hcloud_server.kubernetes.ipv4_address}"
  }
}
