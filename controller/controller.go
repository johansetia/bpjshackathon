package controller

// <maintainer: johansetiawan>

import (
	"encoding/json"
	"net/http"
	"runtime"

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

// NotificationDayTwo is
func NotificationDayTwo() {
	// gu := new(modeluser.Data)
	// uss := gu.Get()

	// get all user
	// for each => get analisa
	// push msg
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
