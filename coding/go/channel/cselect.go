package main

import (
	"fmt"
	"time"
)

var ch chan int

func main() {

	ch = make(chan int)

	go writer()

	for i := 0; i < 10; i++ {

		fmt.Println("main:", i)

		ch <- i

		time.Sleep(1 * time.Second)

	}

	time.Sleep(100 * time.Second)

}

func writer() {
	var tmp int
	var s3 []int = make([]int, 0)

	for {
		select {
		case tmp = <-ch:
			s3 = append(s3, tmp)
		default:
		}
		for index, value := range s3 {
			fmt.Println("index: %v, value:%v\n", index, value)
		}

		time.Sleep(time.Second)

	}

}
