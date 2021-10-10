data "aws_caller_identity" "self" {}

data "aws_iam_policy_document" "enforce_mfa_device" {
  statement {
    effect = "Allow"
    actions = [
      "iam:CreateVirtualMFADevice",
      "iam:EnableMFADevice",
      "iam:ResyncMFADevice",
      "iam:DeleteVirtualMFADevice"
    ]
    resources = [
      format(
        "arn:aws:iam::%s:mfa/%s",
        data.aws_caller_identity.self.account_id,
        local.outputs.username,
      ),
      aws_iam_user.this.arn,
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "iam:DeactivateMFADevice",
    ]

    resources = [
      aws_iam_user.this.arn,
      format(
        "arn:aws:iam::%s:mfa/%s",
        data.aws_caller_identity.self.account_id,
        local.outputs.username,
      ),
    ]

    condition {
      test     = "Bool"
      variable = "aws:MultiFactorAuthPresent"
      values   = [true]
    }

  }

  statement {
    effect = "Allow"
    actions = [
      "iam:DeleteVirtualMFADevice",
      "iam:ListMFADevices",
      "iam:ListVirtualMFADevices",
    ]
    condition {
      test     = "Bool"
      variable = "aws:MultiFactorAuthPresent"
      values   = [true]
    }
    resources = [
      aws_iam_user.this.arn,
      format(
        "arn:aws:iam::%s:mfa/%s",
        data.aws_caller_identity.self.account_id,
        local.outputs.username,
      ),
    ]
  }
  statement {
    effect = "Allow"
    actions = [
      "iam:ListMFADevices",
      "iam:ListUsers",
      "iam:ListVirtualMFADevices",
    ]
    resources = [
      aws_iam_user.this.arn,
      format(
        "arn:aws:iam::%s:mfa/%s",
        data.aws_caller_identity.self.account_id,
        local.outputs.username,
      ),
    ]

  }
  statement {
    effect = "Deny"
    not_actions = [
      "iam:CreateVirtualMFADevice",
      "iam:DeleteVirtualMFADevice",
      "iam:EnableMFADevice",
      "iam:GetAccountPasswordPolicy",
      "iam:ListMFADevices",
      "iam:ListUsers",
      "iam:ListVirtualMFADevices",
      "iam:ResyncMFADevice",
    ]
    condition {
      test     = "BoolIfExists"
      variable = "aws:MultiFactorAuthPresent"
      values   = ["false"]
    }
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "password" {
  statement {
    effect = "Allow"
    actions = [
      "iam:ChangePassword",
      "iam:GetLoginProfile"
    ]
    resources = [
      aws_iam_user.this.arn
    ]
  }
}

data "aws_iam_policy_document" "access_key" {
  statement {
    effect = "Allow"
    actions = [
      "iam:CreateAccessKey",
      "iam:DeleteAccessKey",
      "iam:GetAccessKeyLastUsed",
      "iam:GetUser",
      "iam:ListAccessKeys",
      "iam:UpdateAccessKey"
    ]
    resources = [
      aws_iam_user.this.arn,
    ]
  }
}
