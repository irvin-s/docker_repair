FROM logentries/docker-logentries  
COPY entrypoint.sh /  
ENTRYPOINT ["/entrypoint.sh"]  
CMD []  

