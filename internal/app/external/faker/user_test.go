package faker

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestFakeUserName(t *testing.T) {
	assert.Contains(t, names, User().Name())
}

func TestFakeUserFirstName(t *testing.T) {
	assert.Contains(t, firstNames, User().FirstName())
}

func TestFakeUserPath(t *testing.T) {
	assert.Contains(t, paths, User().Path())
}
