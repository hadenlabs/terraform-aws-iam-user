package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"

	"github.com/hadenlabs/terraform-aws-iam-user/config"
	"github.com/hadenlabs/terraform-aws-iam-user/internal/app/external/faker"
	"github.com/hadenlabs/terraform-aws-iam-user/internal/common/log"
)

func TestUserWithBasic(t *testing.T) {
	t.Parallel()
	conf := config.Must()
	logger := log.Factory(*conf)
	username := faker.User().Name()
	firstName := faker.User().FirstName()
	path := faker.User().Path()
	publicKey := "../fixtures/keys/terraform-aws-iam-user-testing.pub"
	logger.Debugf(
		"values for test user-basic aws is",
		"username", username,
		"firstname", firstName,
		"path", path,
	)

	terraformOptions := &terraform.Options{
		// The path to where your Terraform code is located
		TerraformDir: "user-basic",
		Upgrade:      true,
		Vars: map[string]interface{}{
			"username":   username,
			"first_name": firstName,
			"path":       path,
			"public_key": publicKey,
		},
	}

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)
}
