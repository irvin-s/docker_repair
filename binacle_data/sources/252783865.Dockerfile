FROM golang:1.9  
# ENV http_proxy "socks5://HOST:PORT"  
# ENV https_proxy "socks5://HOST:PORT"  
COPY . "$GOPATH/src/github.com/Binly42/agenda-go2"  
  
RUN go get -u -v "github.com/Binly42/agenda-go2/cli"  
RUN go get -u -v "github.com/Binly42/agenda-go2/service"  
  
WORKDIR "$GOPATH/src/github.com/Binly42/agenda-go2"  
  
RUN go install "./cli"  
RUN go install "./service"  
  
EXPOSE 8080  
VOLUME ["/service/.agenda.d"]  

