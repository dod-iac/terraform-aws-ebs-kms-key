output "aws_kms_alias_arn" {
  description = "The Amazon Resource Name (ARN) of the key alias."
  value       = aws_kms_alias.ebs.arn
}

output "aws_kms_alias_name" {
  description = "The display name of the alias."
  value       = aws_kms_alias.ebs.name
}

output "aws_kms_key_arn" {
  description = "The Amazon Resource Name (ARN) of the key."
  value       = aws_kms_key.ebs.arn
}
