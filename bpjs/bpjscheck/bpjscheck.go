package bpjscheck

import (
	"bytes"
	"encoding/json"
	"fmt"
	"io/ioutil"
	"net/http"
)

// AdapterURL s
var AdapterURL string

// HistoryEND is
const HistoryEND = "/BPJSComp/webresources/historyPayment"

// Request is
type Request struct {
	NoKK     string
	Request  string
	Response string
	Status   int
}

// History s
type History struct {
	Status string `json:"status"`
	Msg    string `json:"message"`
	H      []struct {
		TrxID string `json:"transactionId"`
		Nama  string `json:"nama"`
	} `json:"history"`
}

// Check is
func (h *Request) Check() bool {
	type R struct {
		B string `json:"nomorKepalaKeluarga"`
	}
	r := new(R)
	r.B = h.NoKK

	bson, err := json.Marshal(r)
	if err != nil {
		return false
	}
	// fmt.Println(string(bson))

	req, err := http.NewRequest("POST", AdapterURL+HistoryEND, bytes.NewBuffer(bson))
	req.Header.Set("Content-Type", "application/json")

	client := &http.Client{}
	resp, err := client.Do(req)
	if err != nil {
		fmt.Println(err)
		return false
	}

	defer resp.Body.Close()
	body, _ := ioutil.ReadAll(resp.Body)

	Resp := new(History)
	err = json.Unmarshal(body, Resp)
	if err != nil {
		return false
	}

	h.Response = string(body)
	h.Status = len(Resp.H)

	return true
}
