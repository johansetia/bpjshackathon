package helper

// <maintainer: johansetiawan>

// Resp o
type Resp struct {
	Status bool        `json:"status"`
	Error  interface{} `json:"error,omitempty"`
	Data   interface{} `json:"data,omitempty"`
}

// Socket i
type Socket struct {
	ID      string      `json:"id"`
	Status  string      `json:"status"`
	Title   string      `json:"title"`
	Message string      `json:"message"`
	Data    interface{} `json:"data,omitempty"`
}

// Action s
type Action struct {
	Action string `json:"action"`
	Level  string `json:"level"`
}
