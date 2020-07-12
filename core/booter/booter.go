package booter

// <maintainer: johansetiawan>

import (
	"fmt"
	"log"
	"os"

	"github.com/johansetia/bpjshackathon/controller"
	"github.com/johansetia/bpjshackathon/core/databases"
	"github.com/johansetia/bpjshackathon/core/notify"
	"github.com/joho/godotenv"
	"github.com/labstack/echo/v4"
	m "github.com/labstack/echo/v4/middleware"
)

// Addr is
var Addr string

// Warm is
func Warm() bool {
	// Load ENV
	err := godotenv.Load(".env")
	if err != nil {
		return false
	}

	user := os.Getenv("DB_USERNAME")
	port := os.Getenv("DB_PORT")
	addr := os.Getenv("DB_ADDR")
	pswd := os.Getenv("DB_PASSWORD")
	dbname := os.Getenv("DB_NAME")

	// assigning a  connection databases variable with db env structure
	databases.Key = user + ":" + pswd + "@(" + addr + ":" + port + ")/" + dbname

	_, err = databases.MainDB()
	if err != nil {
		log.Println(err)
	}
	saddr := os.Getenv("SERVER_ADDR")
	sport := os.Getenv("SERVER_PORT")

	if saddr == "" || sport == "" {
		return false
	}
	Addr = saddr + ":" + sport
	fmt.Println("⇨ file .env has been loaded")
	return true
}

// Run is
func Run() {
	e := echo.New()
	e.HideBanner = true
	e.Use(m.RecoverWithConfig(m.RecoverConfig{
		Skipper:           m.DefaultSkipper,
		StackSize:         7 << 10, // 7 KB
		DisableStackAll:   false,
		DisablePrintStack: false,
	}))
	e.POST("/open", controller.APIPush)
	e.GET("/notify", notify.Server)
	e.Logger.Fatal(e.Start(Addr))
}
