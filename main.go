package main

import (
	"log"
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
		var result []string

		// Hash [0..99], append to array
		for i := 0; i < 100; i++ {
			log.Println(i)

			s := strconv.Itoa(i)
			hashed, err := bcrypt.GenerateFromPassword([]byte(s), 2)

			if err != nil {
				return err
			}

			result = append(result, string(hashed))
		}

		// Return hash results
		return c.JSON(result)
	})

	app.Listen(":3000")
}
