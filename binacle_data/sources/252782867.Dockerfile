FROM golang:1.6  
  
RUN go get github.com/urfave/negroni && \  
go get github.com/urfave/cli && \  
go get github.com/gorilla/mux && \  
go get github.com/satori/go.uuid  

