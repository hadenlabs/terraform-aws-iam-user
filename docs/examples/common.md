### common

```hcl
  module "main" {
    source  = "hadenlabs/iam-user/aws"
    version = "0.0.0"

    providers = {
      aws = aws
    }
  }
```
