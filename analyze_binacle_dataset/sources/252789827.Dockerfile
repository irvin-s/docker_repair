  
FROM alpine:latest  
  
MAINTAINER caligari@treboada.net  
  
RUN apk --no-cache add privoxy  
ADD privoxy-start.sh /usr/local/bin/  
ADD config /etc/privoxy/  
RUN chmod +r /etc/privoxy/config && chmod +x /usr/local/bin/privoxy-start.sh  
  
CMD ["privoxy-start.sh"]  
  
EXPOSE 8118  
  

