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

	// CRED OPERATIONS

	// inserting values to table

	in_qry := `INSERT INTO A1 (usr_name,usr_pwd) VALUES ($1,$2)`

	_, err = db.Exec(in_qry, "jaseela", "jas123")
	if err != nil {
		log.Fatal(err)
	}
	fmt.Println("inserted succesfully")

	// inserting values to table with returning id

	in_qry = `INSERT INTO A1 (usr_name,usr_pwd) VALUES ($1,$2) RETURNING id`

	t_id := 0
	err = db.QueryRow(in_qry, "badusha", "bad123").Scan(&t_id)
	if err != nil {
		log.Fatal(err)
	}
	fmt.Println("inserted id is", t_id)

	// update table

	up_qry := `UPDATE A1 SET usr_pwd=$1 WHERE id=$2 RETURNING id`

	t_id = 0
	err = db.QueryRow(up_qry, "fasil123", 1).Scan(&t_id)
	if err != nil {
		log.Fatal(err)
	}
	fmt.Println("updated id is", t_id)

	// delete table row

	dlt_qry := `DELETE FROM A1 WHERE id=$1 RETURNING id`
	err = db.QueryRow(dlt_qry, 1).Scan(&t_id)
	if err != nil {
		log.Fatal(err)
	}
	fmt.Println("deleted id is", t_id)

	//		SELECT

	// select single row

	id := 0
	var username, userpwd string
	slt_qry := `SELECT id,usr_name,usr_pwd FROM A1 WHERE id=$1`
	row := db.QueryRow(slt_qry, 2)
	err = row.Scan(&id, &username, &userpwd)
	switch err {
	case sql.ErrNoRows:
		fmt.Println("Oops there is no data you search")
	case nil:
		fmt.Printf("\nid=%d \nname=%s \npassword=%s\n", id, username, userpwd)
	default:
		log.Fatal(err)
	}

}
