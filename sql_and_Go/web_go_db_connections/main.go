package main

import (
	// packages provided by golang
	"database/sql"
	"fmt"
	"html/template"
	"log"
	"net/http"

	// third party / external pakages
	_ "github.com/lib/pq"
)

var tpl *template.Template

// var db *sql.DB

func init() {
	tpl = template.Must(template.ParseGlob("templates/*"))
}

func conectdb() (*sql.DB, error) {

	// Provide credencials fot database
	const (
		host     = "localhost"
		port     = 5432
		user     = "fasil"
		database = "my_db"
		password = "0000"
	)

	// dns-data sorce name

	dsn := fmt.Sprintf("host=%s port=%d user=%s password=%s dbname=%s sslmode=disable", host, port, user, password, database)

	// Establish connections to the database and returning if any error

	db, err := sql.Open("postgres", dsn)
	if err != nil {
		return nil, err
	}

	// checking the connections using ping and returning if any error

	err = db.Ping()
	if err != nil {
		return nil, err
	}

	// returning the database

	return db, nil

}

// create a struct of the database for the deppentency

type application struct {
	db *sql.DB
}

func main() {

	// connect db using funtion

	var db, err = conectdb()

	// here checking if any error return from the connectdb() it callde globaly

	if err != nil {
		log.Fatal("Oops db not connected : ", err)
	}
	fmt.Print("\nDatabase connected succesfully\n\n")

	// database close before exit this function

	defer db.Close()

	// creating struct object

	app := &application{
		db: db,
	}

	// handile functions
	// call by struct methord

	mux := http.NewServeMux()
	mux.HandleFunc("/", app.Home)
	mux.HandleFunc("/insert", app.Insert)

	// establishing server

	log.Println("\n  Starting server at port no :8080")
	err = http.ListenAndServe(":8080", mux)
	if err != nil {
		log.Fatal("Oops : ", err)
	}

}
