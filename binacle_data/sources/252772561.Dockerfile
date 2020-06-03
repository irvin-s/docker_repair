FROM cassandra:3.9  
RUN apt-get update && \  
apt-get install dnsutils -y  
  
COPY entrypoint.sh /entrypoint.sh  
RUN chmod a+x /entrypoint.sh  
  
ENTRYPOINT ["/entrypoint.sh"]  
CMD ["cassandra", "-f"]  

