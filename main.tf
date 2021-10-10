locals {
  defaults = {
    password_reset_required = false
    path                    = "/"
  }

  input = {
    username                = var.username
    first_name              = var.first_name
    path                    = var.path == null ? local.defaults.path : var.path
    public_key              = var.public_key
    password_reset_required = try(var.password_reset_required, local.defaults.password_reset_required)
  }

  generated = {
    username                = local.input.username
    first_name              = local.input.first_name
    path                    = local.input.path
    public_key              = local.input.public_key
    password_reset_required = local.input.password_reset_required
  }

  outputs = {
    username                = local.generated.username
    first_name              = local.generated.first_name
    path                    = local.generated.path
    public_key              = local.generated.public_key
    password_reset_required = local.generated.password_reset_required
  }

}

resource "aws_iam_user" "this" {
  name          = local.outputs.username
  path          = local.outputs.path
  force_destroy = true

  tags = {
    managed-by = "Terraform"
    Name       = local.outputs.username
  }
}

resource "aws_iam_access_key" "this" {
  depends_on = [
    aws_iam_user.this
  ]
  user = aws_iam_user.this.name
}

resource "aws_iam_user_ssh_key" "this" {
  depends_on = [
    aws_iam_user.this
  ]
  username   = aws_iam_user.this.name
  encoding   = "SSH"
  public_key = local.outputs.public_key
}

resource "aws_iam_policy" "mfa" {
  depends_on = [
    aws_iam_user.this
  ]
  policy = data.aws_iam_policy_document.enforce_mfa_device.json
}

resource "aws_iam_policy" "password" {
  depends_on = [
    aws_iam_user.this
  ]
  policy = data.aws_iam_policy_document.password.json
}

resource "aws_iam_policy" "access_key" {
  depends_on = [
    aws_iam_user.this
  ]
  policy = data.aws_iam_policy_document.access_key.json
}

# Avoid this for Reducing access management complexity
resource "aws_iam_user_policy_attachment" "mfa" {
  depends_on = [
    aws_iam_user.this
  ]
  user = aws_iam_user.this.name

  # checkov:skip=CKV_AWS_40: Avoid this
  policy_arn = aws_iam_policy.mfa.arn
}

resource "aws_iam_user_policy_attachment" "password" {
  depends_on = [
    aws_iam_user.this
  ]
  user = aws_iam_user.this.name

  # checkov:skip=CKV_AWS_40: Avoid this
  policy_arn = aws_iam_policy.password.arn
}

resource "aws_iam_user_policy_attachment" "access_key" {
  depends_on = [
    aws_iam_user.this
  ]
  user = aws_iam_user.this.name

  # checkov:skip=CKV_AWS_40: Avoid this
  policy_arn = aws_iam_policy.access_key.arn
}
