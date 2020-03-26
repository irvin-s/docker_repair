FROM alpine:3.6  
LABEL maintainer "Krzysztof Szarek"  
  
ARG BATS_VERSION=0.4.0-r2  
RUN apk add --no-cache bash bats=$BATS_VERSION  
  
WORKDIR /code  
  
ENTRYPOINT ["/usr/bin/bats"]  
  
CMD ["-v"]  

