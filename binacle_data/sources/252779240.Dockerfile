FROM alpine:latest  
MAINTAINER Alex Bytes bytesizedalex@users.noreply.github.com  
LABEL Name=python Version=1.0.1  
RUN apk add python --no-cache && rm -f /var/cache/apk/*  
ENTRYPOINT ["python"]  

