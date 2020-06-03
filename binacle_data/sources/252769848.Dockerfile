FROM golang  
MAINTAINER https://github.com/aronahl  
RUN go get github.com/htcat/htcat/cmd/htcat  
ENTRYPOINT ["htcat"]  
CMD []  

