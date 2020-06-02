FROM alpine:latest  
LABEL maintainer "Anthony Neto <anthony.neto@gmail.com>"  
  
RUN apk --no-cache add \  
parted  
  
ENTRYPOINT [ "parted" ]  
CMD ["-h"]  

