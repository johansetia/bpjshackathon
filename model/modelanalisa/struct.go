package modelanalisa

// Tn oi
const Tn = "analysis"

type (
	// Data o
	Data struct {
		MainNum        string `gorm:"column:bpjs_number"`
		Provinsi       string `gorm:"column:provinsi"`
		SalaryGrade    string `gorm:"column:salary_grade"`
		Kelas          string `gorm:"column:kelas"`
		Work           string `gorm:"column:work"`
		TotalMenunggak int    `gorm:"column:total_menunggak"`
		Overlap        int    `gorm:"column:overlap"`
		Level          string `gorm:"column:level"`
		PL             Prob
		S              Search
		R              Result
	}

	// Result o
	Result struct {
		PLow    float64
		PMed    float64
		PHard   float64
		PFreeze float64
		Status  string
	}
	// Ctr s
	Ctr struct {
		Fill string  `gorm:"column:fill"`
		Tot  float64 `gorm:"column:tot"`
		Sum  float64 `gorm:"-"`
	}

	// Ctrs s
	Ctrs []Ctr

	// Prob s
	Prob map[string][]float64

	// Res s
	Res map[string]float64

	// Search is
	Search map[string]string
)

var (
	// Level is
	Level = []string{"LOW", "MEDIUM", "HARD", "FREEZE"}
	// Table is
	Table = []string{"provinsi", "salary_grade", "kelas", "work", "total_menunggak", "overlap"}
	// selector is
	selector = "count(idanalysis) AS tot"
)

// TableName d
func (Data) TableName() string {
	return Tn
}
