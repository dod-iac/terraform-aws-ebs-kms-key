<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Usage

Creates a KMS Key for use with AWS EBS.

```hcl
module "ebs_kms_key" {
  source = "dod-iac/ebs-kms-key/aws"

  name = format("alias/app-%s-ebs-%s", var.application, var.environment)
  description = format("A KMS key used to encrypt EBS volumes for %s:%s.", var.application, var.environment)
  tags = {
    Application = var.application
    Environment = var.environment
    Automation  = "Terraform"
  }
}
```

## Terraform Version

Terraform 0.13. Pin module version to ~> 1.0.0 . Submit pull-requests to main branch.

Terraform 0.11 and 0.12 are not supported.

## License

This project constitutes a work of the United States Government and is not subject to domestic copyright protection under 17 USC § 105.  However, because the project utilizes code licensed from contributors and other third parties, it therefore is licensed under the MIT License.  See LICENSE file for more information.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.0, < 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.0, < 5.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_kms_alias.ebs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_key.ebs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.ebs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_description"></a> [description](#input\_description) | n/a | `string` | `"A KMS key used to encrypt EBS volumes."` | no |
| <a name="input_key_deletion_window_in_days"></a> [key\_deletion\_window\_in\_days](#input\_key\_deletion\_window\_in\_days) | Duration in days after which the key is deleted after destruction of the resource, must be between 7 and 30 days. | `string` | `30` | no |
| <a name="input_name"></a> [name](#input\_name) | The display name of the alias. The name must start with the word "alias" followed by a forward slash (alias/). | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags applied to the KMS key. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_kms_alias_arn"></a> [aws\_kms\_alias\_arn](#output\_aws\_kms\_alias\_arn) | The Amazon Resource Name (ARN) of the key alias. |
| <a name="output_aws_kms_alias_name"></a> [aws\_kms\_alias\_name](#output\_aws\_kms\_alias\_name) | The display name of the alias. |
| <a name="output_aws_kms_key_arn"></a> [aws\_kms\_key\_arn](#output\_aws\_kms\_key\_arn) | The Amazon Resource Name (ARN) of the key. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
