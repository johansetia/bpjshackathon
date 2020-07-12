package main

// <maintainer: johansetiawan>

import (
	"github.com/johansetia/bpjshackathon/core/booter"
	"github.com/johansetia/bpjshackathon/core/crony"
)

func init() {
	booter.Warm()
	crony.Warm()
}

func main() {
	booter.Run()
}
