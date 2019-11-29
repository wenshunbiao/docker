FROM golang:1.8.3-alpine
RUN apk add --no-cache git build-base bash
RUN go get github.com/anacrolix/torrent
RUN go get github.com/mattn/go-isatty
RUN go get github.com/anacrolix/envpprof
RUN go get github.com/anacrolix/tagflag
RUN go get github.com/gosuri/uiprogress
RUN cd /go/src/github.com/anacrolix/torrent/cmd/torrent && GOOS=windows GOARCH=386 go build -o torrent.exe main.go
