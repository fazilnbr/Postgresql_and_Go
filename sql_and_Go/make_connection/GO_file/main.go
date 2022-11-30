package main

import (
	// provide by go
	"database/sql"
	"fmt"
	"log"

	// third party pakage
	_ "github.com/lib/pq"
)

// Provide credencials fot database
const (
	host     = "localhost"
	port     = 5432
	user     = "fasil"
	database = "my_db"
	password = "0000"
)

func main() {

	// dns-data sorce name

	dsn := fmt.Sprintf("host=%s port=%d user=%s password=%s dbname=%s sslmode=disable", host, port, user, password, database)

	// Establish connections to the database

	db, err := sql.Open("postgres", dsn)
	if err != nil {
		log.Fatal(err)
	}
	defer db.Close() //It work before exit this function

	// checking the connections

	err = db.Ping()
	if err != nil {
		fmt.Println("connection was succesfull")
	}

	qry := `INSERT INTO A1 (usr_name,usr_pwd) VALUES ($1,$2)`

	_, err = db.Exec(qry, "ajal", "aja123")
	if err != nil {
		log.Fatal(err)
	}
	fmt.Println("inserted succesfully")
}
