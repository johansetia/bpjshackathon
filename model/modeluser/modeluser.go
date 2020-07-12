package modeluser

import (
	"github.com/johansetia/bpjshackathon/core/databases"
)

// Tn i
const Tn = "user"

// <maintainer: johansetiawan>

// Data i
type Data struct {
	ID            int     `gorm:"column:id"`
	MainBPJSNum   string  `gorm:"column:main_bpjs_number"`
	Name          string  `gorm:"column:first_name"`
	Since         string  `gorm:"column:join_date"`
	Probabilistic float64 `gorm:"-" sql:"-"`
	Status        string  `gorm:"-" sql:"-"`
}

// Users is
type Users []Data

// TableName l
func (Data) TableName() string {
	return Tn
}

// Get s
func (d *Data) Get() *Users {
	uss := new(Users)
	db, err := databases.MainDB()
	if err != nil {
		return uss
	}
	err = db.Table(Tn).Select("id,main_bpjs_number,first_name,join_date").Scan(&uss).Error
	if err != nil {
		return uss
	}
	return uss
}
