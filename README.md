# Terraform module for deploy K8S External DNS

## Cloud Requirements: 
Google Cloud: add to node pool next oauth scope: `"https://www.googleapis.com/auth/ndev.clouddns.readwrite"`

AWS: add policy to IAM role with route53 permissions
   
## Terraform Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12.26 |
| kubernetes | >= 1.11.1 |


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| dns | List of DNS zones | `list(string)` | n/a | yes |
| dns_provider | DNS zone provider | `string` | n/a | yes |
| policy | Would prevent ExternalDNS from deleting any records, omit to enable full synchronization | `string` | `upsert-only` | no |
| aws_zone_type | If `dns_porvider = aws`. Type for hosted zones (valid values are public, private or no value for both) | `string` | `null` | no |
| txt_owner_id | TXT owner value | `string` | `external-dns` | no |
| name | Global name for resources. Used as a prefix | `string` | `external-dns` | no |
| namespace | Namespace name used for all resources | `string` | `external-dns` | no |
| create_namespace | Create namespace or use exist | `bool` | `true` | no |
| namespace_labels | if `create_namespace = true`, add labels to new namespace | `map` | `{}` | no |
| service_account_annotations | Annotations for SA | `map` | `Null` | no |
| image | Docker image repo | `string` | `bitnami/external-dns` | no |
| image_tag | Docker image version tag | `string` | `0.7.4` | no |
| custom_args | Totally custom args for deployment. Most variables will no work, if set any value. Only for expert) | `list(string)}` | `[]` | no |
| additional_args | Additional args for deployment | `list(string)` | `[]` | no |
| env | Add environment variables to deployment | `list(object({ name = string, value = string }))` | `[]` | no |
| node_selector | Specify node selector for deployment | `map(string)` | `null` | no |
| security_context | Security context for deployment | `list` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| service_account | Service Account name which created by module |
| namespace | Namespace which used to deploy resources |