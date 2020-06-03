FROM golang

MAINTAINER Paulo Pizarro <paulo.pizarro@gmail.com> (@ppizarro)

RUN go get golang.org/x/tools/cmd/present

WORKDIR /presentations

EXPOSE 3999

CMD ["present", "-play=true", "-http=0.0.0.0:3999"]
