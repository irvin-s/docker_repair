FROM alpine:3.2  
RUN apk update && apk upgrade \  
&& apk add ca-certificates git openssh curl rsync perl \  
&& rm -rf /var/cache/apk/*  
  
ENTRYPOINT ["git"]  
CMD ["--help"]  

