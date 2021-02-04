/**
 * ## Usage
 *
 * Creates a KMS Key for use with AWS EBS.
 *
 * ```hcl
 * module "ebs_kms_key" {
 *   source = "dod-iac/ebs-kms-key/aws"
 *
 *   name = format("alias/app-%s-ebs-%s", var.application, var.environment)
 *   description = format("A KMS key used to encrypt EBS volumes for %s:%s.", var.application, var.environment)
 *   tags = {
 *     Application = var.application
 *     Environment = var.environment
 *     Automation  = "Terraform"
 *   }
 * }
 * ```
 *
 * ## Terraform Version
 *
 * Terraform 0.13. Pin module version to ~> 1.0.0 . Submit pull-requests to master branch.
 *
 * Terraform 0.11 and 0.12 are not supported.
 *
 * ## License
 *
 * This project constitutes a work of the United States Government and is not subject to domestic copyright protection under 17 USC § 105.  However, because the project utilizes code licensed from contributors and other third parties, it therefore is licensed under the MIT License.  See LICENSE file for more information.
 */

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_partition" "current" {}

data "aws_iam_policy_document" "ebs" {
  policy_id = "key-policy-ebs"
  statement {
    sid = "Enable IAM User Permissions"
    actions = [
      "kms:*",
    ]
    effect = "Allow"
    principals {
      type = "AWS"
      identifiers = [
        format(
          "arn:%s:iam::%s:root",
          data.aws_partition.current.partition,
          data.aws_caller_identity.current.account_id
        )
      ]
    }
    resources = ["*"]
  }
  statement {
    sid = "Allow EC2 to use the key"
    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:CreateGrant",
      "kms:DescribeKey"
    ]
    effect = "Allow"
    principals {
      type = "AWS"
      identifiers = [
        "*"
      ]
    }
    resources = ["*"]
    condition {
      test     = "StringEquals"
      variable = "kms:CallerAccount"
      values   = [data.aws_caller_identity.current.account_id]
    }
    condition {
      test     = "StringEquals"
      variable = "kms:ViaService"
      values   = [format("ec2.%s.amazonaws.com", data.aws_region.current.name)]
    }
  }
}

resource "aws_kms_key" "ebs" {
  description             = var.description
  deletion_window_in_days = var.key_deletion_window_in_days
  enable_key_rotation     = "true"
  policy                  = data.aws_iam_policy_document.ebs.json
  tags                    = var.tags
}

resource "aws_kms_alias" "ebs" {
  name          = var.name
  target_key_id = aws_kms_key.ebs.key_id
}
