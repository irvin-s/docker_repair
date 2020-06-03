FROM golang  
ADD . $GOPATH/src/github.com/durksauce/GoFinance  
WORKDIR $GOPATH/src/github.com/durksauce/GoFinance  
RUN go get github.com/gorilla/mux  
RUN go get github.com/gorilla/handlers  
RUN go get github.com/go-sql-driver/mysql  
RUN go get github.com/dgrijalva/jwt-go  
RUN go install github.com/durksauce/GoFinance  
ENTRYPOINT $GOPATH/bin/GoFinance  
EXPOSE 8080  

