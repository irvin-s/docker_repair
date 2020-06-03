FROM golang:alpine  
  
RUN apk --update add git \  
&& go get github.com/mpolden/ipd/...  
  
FROM alpine:latest  
# RUN apk --no-cache add ca-certificates \  
COPY \--from=0 /go/bin/ipd /bin/ipd  
  
EXPOSE 8080  
COPY docker-entrypoint.sh /  
ENTRYPOINT ["/docker-entrypoint.sh"]  
CMD ["ipd"]  

