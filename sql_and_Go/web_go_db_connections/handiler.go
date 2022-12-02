package main

import (
	"fmt"
	"log"
	"net/http"
	"time"
)

// create a struct

type table_data struct {
	Id       int
	Name     string
	Password string
	Created  time.Time
}

// all methords change in to struct methord

func (app *application) Home(w http.ResponseWriter, r *http.Request) {
	err := tpl.ExecuteTemplate(w, "signup.html", nil)
	if err != nil {
		fmt.Println("error while parsing file", err)
		return
	}

}

func (app *application) Insert(w http.ResponseWriter, r *http.Request) {

	// checking method is post or not if any error it redirect and returns

	if r.Method != http.MethodPost {
		http.Redirect(w, r, "/", http.StatusSeeOther)
		return
	}

	// parsing data from the template and error checking if any error it returns

	err := r.ParseForm()
	if err != nil {
		http.Error(w, http.StatusText(http.StatusBadRequest),
			http.StatusBadRequest)
		return
	}

	// geting data to variables

	uname := r.PostForm.Get("firstName")
	upwd := r.PostForm.Get("password")

	// fmt.Printf("\n\n\nu_name  :%s\n\n\npwd  :%s\n\n\n", uname, upwd)

	// set inserting qurey and exicute it

	in_qry := `INSERT INTO A1 (usr_name,usr_pwd) VALUES ($1,$2)`

	// db execute using app obj

	_, err = app.db.Exec(in_qry, uname, upwd)
	if err != nil {
		log.Panicln(err.Error())
		http.Error(w, http.StatusText(http.StatusInternalServerError), http.StatusInternalServerError)
	}
	fmt.Println("inserted succesfully")
	http.Redirect(w, r, "/", http.StatusSeeOther)

}

func (app *application) Display(w http.ResponseWriter, r *http.Request) {

	// var tm string
	// sql query

	slt_qry := `SELECT * FROM A1`

	// exicute the query and retreve the data

	row, err := app.db.Query(slt_qry)
	if err != nil {
		log.Println(err.Error())
		http.Error(w,
			http.StatusText(http.StatusInternalServerError),
			http.StatusInternalServerError)
	}

	defer row.Close() // row close when this function

	// declare the table data struct

	var td []table_data

	// loop thrugh the each row and append to the td

	for row.Next() {

		var tr table_data

		err = row.Scan(&tr.Id, &tr.Name, &tr.Password, &tr.Created)

		if err != nil {
			log.Println(err.Error())
			http.Error(w,
				http.StatusText(http.StatusInternalServerError),
				http.StatusInternalServerError)
		}

		// tm = tr.created.Format("2006-January-02")
		// fmt.Print("\n\n", tr.created, "\n\n")

		td = append(td, tr)

	}

	// checking if any error occur on the row loop itration

	err = row.Err()

	if err != nil {
		log.Println(err.Error())
		http.Error(w,
			http.StatusText(http.StatusInternalServerError),
			http.StatusInternalServerError)
	}

	// for _, data := range td {
	// 	// fmt.Fprintln(w, " \n", data.id, data.name, data.password, tm)
	// 	fmt.Fprintln(w, " \n", data)
	// }
	// fmt.Println(td)

	// here we pass that table data(td) to the web

	err = tpl.ExecuteTemplate(w, "show.html", td)
	if err != nil {
		fmt.Println("error while parsing file", err)
		return
	}
}
