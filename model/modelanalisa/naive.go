package modelanalisa

import (
	"strconv"

	"github.com/johansetia/bpjshackathon/core/databases"
)

// <maintainer: johansetiawan>

func (d *Data) getProbability() {
	type SF64 []float64
	db, err := databases.MainDB()
	if err != nil {
		return
	}

	n := new(Ctr)
	// get total rows
	err = db.Table(Tn).Select(selector).
		Scan(&n).Error
	// make a clone variable
	M := make(Prob)
	// search by level / reverse naive bayes
	for _, l := range Level {
		var F64 SF64
		x := new(Ctr)
		// get level probability
		db.Table(Tn).Select(selector).
			Where("level = ?", l).
			Scan(&x)

		// probability
		mast := x.Tot / n.Tot
		F64 = append(F64, mast)
		// get probability x to y
		for _, f := range Table {
			pxTy := new(Ctr)
			// get probability in x to y based on d.S[f]
			db.Table(Tn).Select(selector).
				Where(f+" = ? AND level = ?", d.S[f], l).
				Scan(&pxTy)
			// probability
			pc := pxTy.Tot / x.Tot
			F64 = append(F64, pc)
		}
		// after making a F64 data it will be inserted to (l) in M
		M[l] = F64
	}
	d.PL = M
	if err != nil {
		return
	}
}

// make a key and value
func (d *Data) genKeyVal() {
	s := make(Search)
	s["provinsi"] = d.Provinsi
	s["salary_grade"] = d.SalaryGrade
	s["kelas"] = d.Kelas
	s["work"] = d.Work
	s["total_menunggak"] = strconv.Itoa(d.TotalMenunggak)
	s["overlap"] = strconv.Itoa(d.Overlap)
	d.S = s
}

// calculaiting probability based on level
func (d *Data) calculate() {
	var res string
	var val float64
	for _, l := range Level {
		for i, prob := range d.PL[l] {
			if l == "LOW" {
				if i == 0 {
					d.R.PLow = prob
				} else {
					d.R.PLow *= prob
				}
			} else if l == "MEDIUM" {
				if i == 0 {
					d.R.PMed = prob
				} else {
					d.R.PMed *= prob
				}
			} else if l == "HARD" {
				if i == 0 {
					d.R.PHard = prob
				} else {
					d.R.PHard *= prob
				}
			} else if l == "FREEZE" {
				if i == 0 {
					d.R.PFreeze = prob
				} else {
					d.R.PFreeze *= prob
				}
			}
		}
	}

	res = "LOW"
	val = d.R.PLow

	if d.R.PMed > val {
		res = "MEDIUM"
		val = d.R.PMed
	}
	if d.R.PHard > val {
		res = "HARD"
		val = d.R.PHard
	}
	if d.R.PFreeze > val {
		res = "FREEZE"
		val = d.R.PFreeze
	}
	d.R.Status = res
}
