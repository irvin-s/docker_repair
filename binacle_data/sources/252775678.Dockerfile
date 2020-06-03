FROM golang  
ADD . /go/src/fileAccess  
RUN go get github.com/fjl/go-couchdb  
RUN go get github.com/gorilla/mux  
RUN go install fileAccess  
ENTRYPOINT /go/bin/fileAccess  
MAINTAINER Laura Chaparro <lachaparrog@unal.edu.co>  
EXPOSE 4025

