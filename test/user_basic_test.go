package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestProjectWithBasic(t *testing.T) {
	username := "dumu"
	firstName := "dump"
	path := "/systems/"
	publicKey := "../fixtures/keys/terraform-aws-iam-user-testing.pub"

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
