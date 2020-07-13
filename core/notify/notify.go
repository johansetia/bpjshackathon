package notify

import (
	"fmt"
	"net/http"

	"github.com/gorilla/websocket"
	"github.com/labstack/echo/v4"
)

// Msg is
var Msg = make(chan string)

// Clients is
var Clients []chan string

func getMsgServer(serverChan chan chan string) {
	for {
		select {
		case client, _ := <-serverChan:
			fmt.Println(client)
			Clients = append(Clients, client)
		case msg, _ := <-Msg:
			// Send the msg to all connected clients:
			for _, c := range Clients {
				c <- msg
			}
		}
	}
}

// Server is
func Server(c echo.Context) error {
	var upgrader = websocket.Upgrader{
		WriteBufferSize: 4096,
		CheckOrigin: func(r *http.Request) bool {
			return true // for testing
		},
	}

	serverChan := make(chan chan string)
	go getMsgServer(serverChan)

	ws, _ := upgrader.Upgrade(c.Response(), c.Request(), nil)

	client := make(chan string)
	serverChan <- client

	for {
		select {
		case txt, _ := <-client:
			go func() {
				writer, err := ws.NextWriter(websocket.TextMessage)

				if err != nil {
					return
				}
				_, err = writer.Write([]byte(txt))
				if err == nil {
					writer.Close()
				} else {
					fmt.Println(err)
				}
			}()

		}
	}
}
