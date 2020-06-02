FROM golang:onbuild  
MAINTAINER Dennis Hedegaard <dennis@dhedegaard.dk>  
ENV LISTEN_ADDR :23231  
ENV GIN_MODE release  
EXPOSE 23231

