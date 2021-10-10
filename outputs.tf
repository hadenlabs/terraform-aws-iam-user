# users
output "user" {
  description = "instance aws_iam_user"
  value       = aws_iam_user.this
}

output "access_key" {
  description = "instance access_key"
  value       = aws_iam_access_key.this
}

output "ssh_key" {
  description = "instance aws_iam_user_ssh_key"
  value       = aws_iam_user_ssh_key.this
}
