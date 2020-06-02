FROM google/golang
MAINTAINER Luciano Antonio Borguetti Faustino <lucianoborguetti@gmail.com>

RUN go get golang.org/x/tools/cmd/present

WORKDIR /presentations

EXPOSE 3999

CMD ["present"]
