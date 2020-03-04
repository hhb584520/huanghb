package main

import (
    "fmt"
    "time"
    "golang.org/x/net/context"
    "go.mongodb.org/mongo-driver/bson"
    "go.mongodb.org/mongo-driver/mongo"
    "go.mongodb.org/mongo-driver/mongo/options"
)

func main() {
    ctx, _ := context.WithTimeout(context.Background(), 10*time.Second)
    client, err := mongo.Connect(ctx, options.Client().ApplyURI("mongodb://localhost:27017"))
    fmt.Println(err)
    collection := client.Database("tst").Collection("numbers")
    ctx, _ = context.WithTimeout(context.Background(), 5*time.Second)
    res, err1  := collection.InsertOne(ctx, bson.M{"name": "pi", "value": 3.14159})
    fmt.Println(err1)
    fmt.Println(res.InsertedID)
}
