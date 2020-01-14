package temperature

func CtoF(c float64) float64 {
    return (c * (9.0 / 5)) + 32
}

func FtoC(f float64) float64 {
    return (f - 32) * (5.0 / 9)
}
