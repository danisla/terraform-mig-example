# Terraform GCP Managed Instance Group Example

How to create a managed instance group with TCP Load Balancer using Terraform.

## Setup

First, configure terraform per the [Google Cloud Provider Configuration Reference](https://www.terraform.io/docs/providers/google/index.html#configuration-reference)

Make sure your project name and credentials are exported as variables:

```
export GOOGLE_PROJECT=$(gcloud config get-value project)
export GOOGLE_CREDENTIALS=$(cat ~/.config/gcloud/terraform-admin.json)
```

## Terraform Apply

Initialize the Terraform workspace:

```
terraform get
```

Preview the changes that terraform will make in your project:

```
terraform plan
```

Apply the changes:

```
terraform apply
```

Show the IP address of the forwarding rule:

```
terraform output -module mig
```

## Scaling the Instance Group

Edit the `terraform.tf` file and change the value of `mig_size` then run `terraform plan` and `terraform apply` to scale the group.
