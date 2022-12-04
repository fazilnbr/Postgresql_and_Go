package initializer

import (
	"makeconnection.net/sqlandgo/go-jwt/models"
) //user defined packages

func SincDatabase() {
	DB.AutoMigrate(&models.User{})
}
