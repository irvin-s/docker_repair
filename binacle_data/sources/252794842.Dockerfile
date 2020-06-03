FROM golang:1.10.1-alpine3.7 AS build-env  
RUN mkdir -p src/github.com/fraunhoferfokus/deckschrubber  
WORKDIR src/github.com/fraunhoferfokus/deckschrubber  
RUN apk --update add git  
RUN git clone https://github.com/fraunhoferfokus/deckschrubber.git .  
RUN git checkout -b tag v0.5.0  
RUN go get .  
RUN go install .  
  
FROM alpine:3.7  
COPY \--from=build-env /go/bin/deckschrubber /bin  
ENTRYPOINT ["deckschrubber"]  
CMD ["--help"]

