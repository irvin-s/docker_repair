FROM alpine:latest  
  
RUN apk -U add dnsmasq inotify-tools && rm -rf /var/cache/apk/*  
  
COPY entrypoint.sh /entrypoint.sh  
  
EXPOSE 53 53/udp  
  
ENTRYPOINT ["/entrypoint.sh"]  
  
CMD ["dnsmasq", "-k", "-q"]  

