FROM sentry:8.7.0  
COPY init-and-start.sh /init-and-start.sh  
RUN chmod +x /init-and-start.sh  
  
ENTRYPOINT ["/init-and-start.sh"]

