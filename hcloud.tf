# Set the variable value in *.tfvars file
# or using the -var="hcloud_token=..." CLI option
variable "hcloud_token" {}

# Configure the Hetzner Cloud Provider
provider "hcloud" {
  token = "${var.hcloud_token}"
}

# Create a server
resource "hcloud_server" "web" {
  name        = "kubernetes"
  image       = "ubuntu-18.04"
  server_type = "cx21"
  ssh_keys    = ["dell"]

  provisioner "remote-exec" {
    inline = [
      "apt-get update",
      "apt-get upgrade",
      "apt-get install -y snapd",
      "snap install microk8s --classic",
      "snap alias microk8s.kubectl kubectl",
      "microk8s.kubectl config view --raw > $HOME/.kube/config"
    ]

    connection {
      host        = "${hcloud_server.web.ipv4_address}"
      type        = "ssh"
      user        = "root"
      private_key = "${file("~/.ssh/id_rsa")}"
      timeout     = "3m"
    }
  }
}
