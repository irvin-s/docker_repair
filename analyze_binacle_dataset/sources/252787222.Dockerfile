FROM nginx:alpine  
  
RUN apk add -U bash && \  
rm -rvf /var/cache/apk/ /var/lib/apk/ /etc/apk/cache/  
  
COPY startup.sh /usr/local/bin/  
RUN chmod +x /usr/local/bin/startup.sh  
  
ENTRYPOINT /usr/local/bin/startup.sh  
  

