# Accept the Go version for the image to be set as a build argument.
# Default to Go 1.9
FROM golang:1.9
COPY http.go /
RUN go build -o /http /http.go
EXPOSE 8000
ENTRYPOINT ["/http"]
