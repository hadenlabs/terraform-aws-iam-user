package test

import (
	"fmt"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	log "github.com/sirupsen/logrus"

	"github.com/hadenlabs/terraform-aws-iam-user/internal/app/external/faker"
)

func TestMultiSuccess(t *testing.T) {
	t.Parallel()
	username := faker.User().Name()
	firstName := faker.User().FirstName()
	path := faker.User().Path()
	publicKey := "../fixtures/keys/terraform-aws-iam-user-testing.pub"
	log.Debug(fmt.Sprintf("value of username %s", username))
	log.Debug(fmt.Sprintf("value of firstName %s", firstName))
	log.Debug(fmt.Sprintf("value of path %s", path))

	terraformOptions := &terraform.Options{
		// The path to where your Terraform code is located
		TerraformDir: "user-multi",
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
