FROM golang

RUN go get golang.org/x/tools/cmd/present

EXPOSE 3999

WORKDIR /slides

CMD present -http=0.0.0.0:3999
