FROM golang:alpine  
MAINTAINER Justin Willis <sirJustin.Willis@gmail.com>  
  
COPY AUTHORS CHANGELOG.md LICENSE README.md main.go /go/src/hastats/  
  
RUN go install -v hastats  
  
EXPOSE 80  
ENTRYPOINT ["hastats"]  

