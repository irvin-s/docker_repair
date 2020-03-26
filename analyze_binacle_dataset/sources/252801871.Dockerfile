FROM alpine:3.5  
COPY talk-json-to-me.sh /usr/local/bin  
RUN chmod +x /usr/local/bin/talk-json-to-me.sh && \  
apk -U add bash jq  
  
ENTRYPOINT ["/usr/local/bin/talk-json-to-me.sh"]  

