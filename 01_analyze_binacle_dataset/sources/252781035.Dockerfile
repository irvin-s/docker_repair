FROM golang:alpine  
  
RUN apk --no-cache add git && \  
go get github.com/constabulary/gb/... && \  
go install github.com/constabulary/gb && \  
apk del git  
  
CMD [ "gb" ]  
  

