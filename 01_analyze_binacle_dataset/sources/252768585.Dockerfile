FROM alpine:3.6  
MAINTAINER Anastas Dancha <anapsix@random.io>  
RUN apk -U upgrade \  
&& apk add nodejs  
WORKDIR /app  
COPY *.sh /  
CMD ["/entrypoint.sh"]  

