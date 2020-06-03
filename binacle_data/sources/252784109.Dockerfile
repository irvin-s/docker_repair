from golang:1.9.3  
ADD gct.go /opt/  
WORKDIR /opt/  
RUN go get github.com/biostream/schemas/go/bmeg  
RUN go build gct.go  
VOLUME /out  
WORKDIR /out  

