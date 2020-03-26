FROM golang:alpine  
  
RUN apk add --no-cache curl git  
  
COPY ./ /go  
  
WORKDIR /go  
RUN curl https://glide.sh/get | sh  
RUN cd src && glide install  
RUN go-wrapper install minio-proxy-go  
  
ENTRYPOINT ["/bin/sh", "-c"]  
#CMD ["/code/docker/minio-proxy-startup.sh"]  
CMD ["minio-proxy-go"]  

