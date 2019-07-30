# microk8s on Hetzner Cloud with Terraform

Setup a Kubernetes cluster for CI/CD integration tests.

## Create the cluster

```
terraform apply -auto-approve -var 'hcloud_token=API_KEY' -var 'hcloud_ssh_key=SSH_KEY_NAME'
```

Disable initial ssh host key checking

```
export ANSIBLE_HOST_KEY_CHECKING=False
```

The kubectl config file will be saved under `/tmp/config`.

## Delete the cluster

```
terraform destroy -force -var 'hcloud_token=API_KEY' -var 'hcloud_ssh_key=SSH_KEY_NAME'
```
