package main

import (
	"fmt"
	"net/http"
	"io/ioutil"
)

func main() {
	url := "https://thepaper.cn"
	resp, err := http.Get(url)
	if err != nil {
		fmt.Println("Get url error", err)
	}

	defer resp.Body.Close()

	if resp.StatusCode != http.StatusOK {
		fmt.Printf("error status code: %v", resp.StatusCode)
	}

	body, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		fmt.Printf("read content failed: %v", err)
	}

	fmt.Println("body:", string(body))
}
