FROM golang:latest  
MAINTAINER arraisgabriel <arraisgabriel@gmail.com>  
  
ENV CADDYGOPATH github.com/mholt/caddy  
ENV CADDYSRC $GOPATH/src/${CADDYGOPATH}  
ARG caddyVersion=v0.10.2  
ARG caddyMainPath="${CADDYSRC}/caddy"  
WORKDIR $GOPATH  
  
RUN go get ${CADDYGOPATH} && \  
cd ${CADDYSRC} && \  
git checkout $caddyVersion && \  
cd $caddyMainPath && \  
#Download all caddy/caddy dependencies  
go get  

