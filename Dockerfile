FROM golang:1.14.6-alpine3.12 as builder
COPY go.mod go.sum /go/src/github.com/Bryce-Soghigian/items-go/
RUN go mod download
COPY . /go/src/github.com/Bryce-Soghigian/items-go/
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o build/items-go github.com/Bryce-Soghigian/items-go/

FROM alpine
RUN apk add --no-cache ca-certificates && update-ca-certificates
COPY --from=builder /go/src/github.com/Bryce-Soghigian/items-go/build/items-go /usr/bin/bucketeer
EXPOSE 8080 8080
ENTRYPOINT ['usr/bin/items-go']
