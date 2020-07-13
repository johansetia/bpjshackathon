package crony

// <maintainer: johansetiawan>

import (
	"fmt"
	"time"

	"github.com/johansetia/bpjshackathon/controller"
	"github.com/johansetia/bpjshackathon/core/notify"
	"github.com/robfig/cron/v3"
)

// Warm is
func Warm() {
	runMinutes(cron.New())
	runSecond(cron.New(
		cron.WithParser(
			cron.NewParser(
				cron.SecondOptional | cron.Minute | cron.Hour | cron.Dom | cron.Month | cron.Dow))))
	fmt.Println("⇨ crony is started")
}

func runMinutes(c *cron.Cron) {
	// At 08:00 on day-of-month 1.
	c.AddFunc("0 8 1 * *", controller.NotificationDayOne)
	// At 08:00 on day-of-month 1.
	c.AddFunc("0 8 2 * *", controller.NotificationDayTwoToTen)
	c.AddFunc("0 8 3 * *", controller.NotificationDayTwoToTen)
	c.AddFunc("0 8 4 * *", controller.NotificationDayTwoToTen)
	c.AddFunc("0 8 5 * *", controller.NotificationDayTwoToTen)
	c.AddFunc("0 8 6 * *", controller.NotificationDayTwoToTen)
	c.AddFunc("0 8 7 * *", controller.NotificationDayTwoToTen)
	c.AddFunc("0 8 8 * *", controller.NotificationDayTwoToTen)
	c.AddFunc("0 8 9 * *", controller.NotificationDayTwoToTen)
	c.AddFunc("0 8 10 * *", controller.NotificationDayTwoToTen)
	c.Start()
}

func runSecond(c *cron.Cron) {
	c.AddFunc("*/5 * * * * *", controller.NotificationDayOne)
	c.AddFunc("*/3 * * * * *", controller.NotificationDayTwoToTen)

	c.Start()
}

func testPush() {
	t := time.Now()
	notify.Msg <- "Helloo it's " + t.Format("15:04:05")
}
