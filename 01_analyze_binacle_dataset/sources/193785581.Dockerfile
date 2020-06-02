FROM google/golang

MAINTAINER Paulo Pizarro <paulo.pizarro@gmail.com> (@ppizarro)

RUN go get golang.org/x/tools/cmd/present

WORKDIR /presentations

EXPOSE 3999

CMD ["present", "-play=true", "-http=172.17.42.1:3999"]
