FROM golang  
RUN go-wrapper download github.com/itchio/gothub  
RUN go-wrapper install github.com/itchio/gothub  

