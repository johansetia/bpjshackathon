package modelanalisa

import (
	"github.com/johansetia/bpjshackathon/core/databases"
)

// <maintainer: johansetiawan>

// NaiveBayes is
func (d *Data) NaiveBayes() *Data {
	db, err := databases.MainDB()
	if err != nil {
		return d
	}
	err = db.Table(Tn).Select("*").
		Where("main_bpjs_number = ?", d.MainNum).
		Scan(&d).Error
	if err != nil {
		return d
	}
	d.analyze()
	return d
}

func (d *Data) analyze() {
	d.genKeyVal()
	d.getProbability()
	d.calculate()
}
