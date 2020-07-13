package controller

// <maintainer: johansetiawan>

import (
	"encoding/json"
	"net/http"
	"runtime"
	"strconv"
	"time"

	"github.com/johansetia/bpjshackathon/bpjs/bpjscheck"
	"github.com/johansetia/bpjshackathon/core/notify"
	"github.com/johansetia/bpjshackathon/helper"
	"github.com/johansetia/bpjshackathon/model/modelanalisa"
	"github.com/johansetia/bpjshackathon/model/modeluser"
	"github.com/labstack/echo/v4"
)

// NotificationDayOne is
func NotificationDayOne() {
	runtime.GOMAXPROCS(4)
	gu := new(modeluser.Data)

	for _, us := range *gu.Get() {
		a := new(modelanalisa.Data)
		a.MainNum = us.MainBPJSNum
		a.NaiveBayes()
		s := a.R.Status

		msg := new(helper.Socket)
		msg.ID = us.MainBPJSNum
		msg.Status = "analisa"
		msg.Title = "Pembayaran BPJS"
		msg.Message = "Hai " + us.Name + ", ayo bayar segera sebelum tanggal 10."
		if s == "LOW" {
			msg.Message += "kamu kan selalu tertib :D"
		} else if s == "MEDIUM" {
			msg.Message += "kamu udah sering terlambat kan ?"
		} else if s == "HARD" {
			msg.Message += "kamu keseringan terlambat nihh"
		} else if s == "FREEZE" {
			msg.Message = "Yuk isi kuisioner dari BPJS"
			d := new(helper.Action)
			d.Action = "yes"
			d.Level = "FREEZE"
			msg.Data = d
		}

		bson, err := json.Marshal(msg)
		if err != nil {
			continue
		}
		notify.Msg <- string(bson)
	}
}

// NotificationDayTwoToTen is
func NotificationDayTwoToTen() {
	gu := new(modeluser.Data)
	currentTime := time.Now()
	date := currentTime.Format("2006-01-02")[8:10]
	dt, _ := strconv.Atoi(date)

	for _, us := range *gu.Get() {
		s := new(bpjscheck.Request)
		s.NoKK = us.MainBPJSNum
		s.Check()

		if s.Status == 0 {
			a := new(modelanalisa.Data)
			a.MainNum = us.MainBPJSNum
			a.NaiveBayes()
			s := a.R.Status

			msg := new(helper.Socket)
			msg.ID = us.MainBPJSNum

			msg.Status = "analisa"
			msg.Title = "Pembayaran BPJS"
			msg.Message = "Hai " + us.Name + ", ayo membayar. "

			if dt >= 2 {
				msg.Message += "Sudah tanggal " + date + " loh,"
			}

			if s == "LOW" {
				msg.Message += "kamu kan selalu tertib :D"
			} else if s == "MEDIUM" {
				msg.Message += "kamu udah sering terlambat kan ?"
			} else if s == "HARD" {
				msg.Message += "kamu keseringan terlambat nihh"
			} else if s == "FREEZE" {
				msg.Message = "Yuk isi kuisioner dari BPJS"
				d := new(helper.Action)
				d.Action = "yes"
				d.Level = "FREEZE"
				msg.Data = d
			}

			if dt == 10 {
				msg.Message += "Status kamu masih belum terbayar lohh"
			}

			bson, err := json.Marshal(msg)
			if err != nil {
				continue
			}
			notify.Msg <- string(bson)
		}
	}

}

// APIPush is
func APIPush(c echo.Context) error {
	r := new(helper.Resp)
	q := new(helper.Socket)
	err := c.Bind(q)
	if err != nil {
		r.Data = "Queue Error"
		return c.JSON(http.StatusCreated, r)
	}
	bson, err := json.Marshal(q)
	if err != nil {
		r.Data = "Internal Error"
		return c.JSON(http.StatusCreated, r)
	}
	notify.Msg <- string(bson)
	r.Status = true
	r.Data = "Queue Success"

	return c.JSON(http.StatusCreated, r)
}
