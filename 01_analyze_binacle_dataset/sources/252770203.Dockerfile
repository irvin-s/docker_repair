FROM couchbase/server  
ENV CB_HOME=/opt/couchbase  
  
COPY *.sh /usr/sbin/  
  
CMD ["/usr/sbin/init.sh"]  

