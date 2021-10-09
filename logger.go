package main

import (
	"log"
	"time"
)

func main() {

	log.Println("Starting!")
	for {
		log.Println("Entering for loop again")
		log.Println("Logging something new")
		log.Println("Waiting 5 seconds!")
		time.Sleep(5 * time.Second)
		log.Println("Oof... im rested now... lets start over")
	}
}
