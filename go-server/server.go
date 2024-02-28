package main

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"log"
	"net/http"
)

// NumberPayload is the structure of the numbers being posted to the server
type NumberPayload struct {
	Numbers []int `json:"numbers"`
}

func main() {
	http.HandleFunc("/RandomWebUrl", func(w http.ResponseWriter, r *http.Request) {
		if r.Method != http.MethodPost {
			http.Error(w, "Method is not supported.", http.StatusMethodNotAllowed)
			return
		}

		body, err := ioutil.ReadAll(r.Body)
		if err != nil {
			http.Error(w, "Error reading request body", http.StatusInternalServerError)
			return
		}

		var payload NumberPayload
		err = json.Unmarshal(body, &payload)
		if err != nil {
			http.Error(w, "Error parsing JSON request body", http.StatusBadRequest)
			return
		}

		// Print the received payload of numbers (in our case, one number)
		fmt.Printf("Received numbers: %v\n", payload.Numbers)

		// Send a status response back to requester
		w.WriteHeader(http.StatusOK)
		w.Write([]byte("Numbers received"))
	})

	log.Println("Server starting on port 7890...")
	if err := http.ListenAndServe(":7890", nil); err != nil {
		log.Fatalf("Error starting server: %s", err)
	}
}
