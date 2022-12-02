package main

import (
	"fmt"
	"log"
	"net/http"
)

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
