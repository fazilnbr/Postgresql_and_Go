package controllers

import (
	"fmt"
	"net/http"
	"os"
	"time"

	"github.com/gin-gonic/gin"
	"github.com/golang-jwt/jwt/v4"
	"golang.org/x/crypto/bcrypt"
	initializer "makeconnection.net/sqlandgo/go-jwt/initializers"
	"makeconnection.net/sqlandgo/go-jwt/models"
)

func Signup(c *gin.Context) {

	// get the email and password of req body

	var body struct {
		Email    string
		Password string
	}
	if c.Bind(&body) != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"error": "failed to read body",
		})
		return
	}

	// hash the password

	hash, err := bcrypt.GenerateFromPassword([]byte(body.Password), 10)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"error": "failed to hash password",
		})
		return
	}

	// create the user

	user := models.User{Email: body.Email, Password: string(hash)}

	result := initializer.DB.Create(&user) // pass pointer of data to Create

	if result.Error != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"error": "failed to create user",
		})
		return
	}

	// respond

	c.JSON(http.StatusOK, gin.H{})

}

func Login(c *gin.Context) {
	// Get the email and password from req body

	var body struct {
		Email    string
		Password string
	}
	if c.Bind(&body) != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"error": "failed to read body",
		})
		return
	}

	// Look up reqested user

	var user models.User

	// fmt.Print("\n\n email :", body.Email, "\npassword :", body.Password, "\n\n")

	// It equals to : SELECT * FROM users WHERE email = requested email;
	initializer.DB.First(&user, "Email = ?", body.Email)

	if user.ID == 0 {
		c.JSON(http.StatusBadRequest, gin.H{
			"error": "invalid user name or password ",
		})
		return
	}

	// Compare sent password with user password hash

	err := bcrypt.CompareHashAndPassword([]byte(user.Password), []byte(body.Password))
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"error": "invalid user name or password ",
		})
		return
	}

	// Create token
	// Create a new token object, specifying signing method and the claims
	// you would like it to contain.
	token := jwt.NewWithClaims(jwt.SigningMethodHS256, jwt.MapClaims{
		"sub": user.ID,
		"exp": time.Now().Add(time.Hour * 24 * 30).Unix(),
	})

	// Sign and get the complete encoded token as a string using the secret

	tokenString, err := token.SignedString([]byte(os.Getenv("SECRET")))
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"error": "failed to create tocken",
		})
		fmt.Println(err)
		return
	}

	// set cookie and Send it back

	c.SetSameSite(http.SameSiteLaxMode)
	c.SetCookie("auth", tokenString, 3600*24*30, "", "", false, true)

	c.JSON(http.StatusOK, gin.H{
		"tocken": tokenString,
	})
}

func Validate(c *gin.Context) {
	user, _ := c.Get("user")
	c.JSON(http.StatusOK, gin.H{
		"meassage": user,
	})
}
