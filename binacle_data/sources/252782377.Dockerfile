FROM alpine:3.4  
RUN apk add --no-cache dropbear openssh rsync bash  
  
# Prepare dropbear  
RUN mkdir /etc/dropbear && touch /var/log/lastlog  
  
COPY add-key /usr/local/bin/add-key  
COPY docker-entrypoint.sh /docker-entrypoint.sh  
ENTRYPOINT ["/docker-entrypoint.sh"]  
  
EXPOSE "22"  
CMD ["dropbear", "-RFEm", "-p", "22"]  

