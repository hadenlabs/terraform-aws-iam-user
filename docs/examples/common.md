### common

```hcl
  module "main" {
      source  = "hadenlabs/iam-user/aws"
      version = "0.0.0"

      username   = var.username
      first_name = var.first_name
      public_key = file(var.public_key)
      path       = var.path
  }
```
