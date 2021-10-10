package faker

import (
	"crypto/rand"
	"math/big"

	"github.com/hadenlabs/terraform-aws-iam-user/internal/errors"
)

type FakeUser interface {
	Name() string      // => "username fake"
	FirstName() string // => "FirstName User"
	Path() string      // => "Path of User"
}

type fakeUser struct{}

func User() FakeUser {
	return fakeUser{}
}

var (
	names      = []string{"user1", "user2"}
	firstNames = []string{"luis", "juan"}
	paths      = []string{"/systems/", "/users/"}
)

func (n fakeUser) Name() string {
	num, err := rand.Int(rand.Reader, big.NewInt(int64(len(names))))
	if err != nil {
		panic(errors.New(errors.ErrorUnknown, err.Error()))
	}
	return names[num.Int64()]
}

func (n fakeUser) FirstName() string {
	num, err := rand.Int(rand.Reader, big.NewInt(int64(len(firstNames))))
	if err != nil {
		panic(errors.New(errors.ErrorUnknown, err.Error()))
	}

	return firstNames[num.Int64()]
}

func (n fakeUser) Path() string {
	num, err := rand.Int(rand.Reader, big.NewInt(int64(len(paths))))
	if err != nil {
		panic(errors.New(errors.ErrorUnknown, err.Error()))
	}
	return paths[num.Int64()]
}
