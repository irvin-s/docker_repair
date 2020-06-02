FROM golang:1.8  
MAINTAINER Ivan Porto Carrero <ivan@flanders.co.nz> (@casualjim)  
  
RUN set -e &&\  
go get -u github.com/mitchellh/gox  
  
ENTRYPOINT ["gox"]  
CMD ["--help"]  

