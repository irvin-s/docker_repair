FROM busybox  
  
RUN mkdir /setup  
COPY functions /setup  
COPY entrypoint.sh /setup  
  
ENTRYPOINT ["/setup/entrypoint.sh"]

