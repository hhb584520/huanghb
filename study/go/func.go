package main

import "fmt"

func otherFunc(f func() string) string {
    return f()
}

func returnTwo() (x, y string) {
    x = "hello"
    y = "world"
    return
}

func sumNumbers(numbers...int) int {
    total := 0
    for _, number := range numbers {
        total += number
    }
    return total
}

func main() {
    fn := func() string {
        return "function called"
    }
    fmt.Println(otherFunc(fn))
    fmt.Println(returnTwo())
    fmt.Println(sumNumbers(1,2,3))
}
