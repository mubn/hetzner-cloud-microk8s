# Configure the Hetzner Cloud Provider
provider "hcloud" {
  token = "${var.hcloud_token}"
}

# Create a server
resource "hcloud_server" "web" {
  name        = "kubernetes"
  image       = "${var.hcloud_image}"
  server_type = "${var.hcloud_server_type}"
  ssh_keys    = ["${var.hcloud_ssh_key}"]

  provisioner "remote-exec" {
    inline = [
      "apt-get update",
      "apt-get upgrade",
      "apt-get install -y snapd",
      "snap install microk8s --classic",
      "snap alias microk8s.kubectl kubectl"
    ]

    connection {
      host        = "${hcloud_server.web.ipv4_address}"
      type        = "ssh"
      user        = "root"
      private_key = "${file("${var.hcloud_key_path}")}"
      timeout     = "3m"
    }
  }
}
