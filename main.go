package main

import (
	"strconv"

	"github.com/gofiber/fiber/v2"
	"golang.org/x/crypto/bcrypt"
)

func main() {
	app := fiber.New()

	app.Get("/ping", func(c *fiber.Ctx) error {
		return c.JSON("pong")
	})

	app.Get("/", func(c *fiber.Ctx) error {

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
