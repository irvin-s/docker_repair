FROM alpine:latest  
MAINTAINER Dennis Hedegaard <dennis@dhedegaard.dk>  
RUN apk add --no-cache --update rust cargo  
WORKDIR /src  
ADD . /src  
CMD sh ./run.sh

