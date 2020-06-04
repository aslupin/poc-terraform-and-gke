## PoC terraform - Using GKE with terraform
following on [Google Container Cluster - Terraform](https://www.terraform.io/docs/providers/google/r/container_cluster.html)

##### note : need create AMI service account.
### Prerequire
- Terraform CLI
- Create project on GCP
- Create service account on GCP:This project use poc-terraform.json (ignore by git)
- Enable Kubernetes Engine API on GCP


### Usage
```bash
terraform init
terraform plan
terraform apply -auto-approve
```

### Git ignore
following ignore files on [Terraform.gitignore](https://github.com/github/gitignore/blob/master/Terraform.gitignore).Add account service that file create on AMI.

