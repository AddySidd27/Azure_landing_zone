# Platform Terraform

This root module deploys the learning platform. It supports the low-cost core-lab configuration and the full-platform configuration.

## Important boundary

The code deploys resources into the subscription configured in the AzureRM provider. The management-group and subscription-placement resources operate at tenant scope when enabled. A production implementation commonly uses separate provider aliases or separate stacks for connectivity, management, security, and workload subscriptions. That separation is documented as an enterprise extension instead of being hidden behind a one-subscription lab.

## Initialize

Copy the selected examples without committing the copies:

```bash
cp ../config/core-lab/backend.hcl.example ../config/core-lab/backend.hcl
cp ../config/core-lab/core-lab.tfvars.example ../config/core-lab/core-lab.auto.tfvars
```

Then run:

```bash
terraform init -backend-config=../config/core-lab/backend.hcl
terraform fmt -check -recursive
terraform validate
terraform plan -var-file=../config/core-lab/core-lab.auto.tfvars -out=core-lab.tfplan
terraform show core-lab.tfplan
terraform apply core-lab.tfplan
```

Do not apply the full-platform configuration until you have reviewed the hourly cost of Azure Firewall, Bastion, and DNS Private Resolver.

