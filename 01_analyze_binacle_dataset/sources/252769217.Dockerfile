FROM angrybytes/nsd:4  
RUN apk add --no-cache tini  
ENTRYPOINT ["/sbin/tini", "--"]  
  
COPY watch.sh /  
CMD ["/bin/sh", "/watch.sh"]  

