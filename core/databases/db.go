package databases

// <maintainer: johansetiawan>

import (
	"errors"

	// _ is used by gorm
	_ "github.com/go-sql-driver/mysql"
	"github.com/jinzhu/gorm"
)

// Key is
var Key string

// Con is
var Con *gorm.DB

// MainDB is used to access the main DB
func MainDB() (*gorm.DB, error) {
	var err error
	if Con == nil {
		Con, err = gorm.Open("mysql", Key)
		if err == nil {
			return Con, nil
		}
	}

	err = Con.DB().Ping()
	if err != nil {
		return nil, errors.New("can't connect to main database")
	}

	return Con, nil
}
