FROM golang:latest
WORKDIR /go/src/github.com/topikettunen/app/
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build .

FROM scratch
COPY --from=0 /go/src/github.com/topikettunen/app/app .
ENTRYPOINT ["/app"]
