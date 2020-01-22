package main

import (
	"fmt"
	"html/template"
	"log"
	"net/http"
	"time"
)

type Welcome struct {
	Name string
	Time string
}
func main() {
	welcome := Welcome{
		Name: "Anonymous",
		Time: time.Now().Format(time.Stamp),
	}
	templates := template.Must(template.ParseFiles("templates/welcome-template.html"))
	http.Handle("/static/", http.StripPrefix("/static/", http.FileServer(http.Dir("static"))))

	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		if name := r.FormValue("name"); name != "" {
			welcome.Name = name
		}
		if err := templates.ExecuteTemplate(w, "welcome-template.html", welcome); err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
		}
	})
	fmt.Println("Listening...")
	log.Fatal(http.ListenAndServe(":9996", nil))
}

