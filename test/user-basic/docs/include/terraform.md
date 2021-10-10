<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >=3.2.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_main"></a> [main](#module\_main) | ../.. | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_first_name"></a> [first\_name](#input\_first\_name) | first name user | `string` | n/a | yes |
| <a name="input_path"></a> [path](#input\_path) | path of user | `string` | `null` | no |
| <a name="input_public_key"></a> [public\_key](#input\_public\_key) | content of file public key | `string` | `null` | no |
| <a name="input_username"></a> [username](#input\_username) | username or alias | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->