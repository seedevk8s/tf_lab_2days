output "aws_account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "default_security_group_id" {
  value = data.aws_security_group.default-sg.id
}
