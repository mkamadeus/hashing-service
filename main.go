package main

import (
	"log"
	"strconv"

	"github.com/gofiber/fiber/v2"
	"golang.org/x/crypto/bcrypt"
)

func main() {
	app := fiber.New()
	req_no := 0

	app.Get("/ping", func(c *fiber.Ctx) error {
		log.Println("Received ping")
		return c.JSON("pong")
	})

	app.Get("/", func(c *fiber.Ctx) error {
		log.Printf("Received req #%v", req_no)
		req_no += 1

		// Hash [0..99]
		for i := 0; i < 100; i++ {
			go func(index int) error {
				s := strconv.Itoa(index)
				_, err := bcrypt.GenerateFromPassword([]byte(s), 2)
				return err
			}(i)
		}

		// Return hash results
		return c.JSON("OK")
	})

	app.Listen(":3000")
}
