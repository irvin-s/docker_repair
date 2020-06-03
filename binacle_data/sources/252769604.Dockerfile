FROM cassandra:3.5  
RUN apt-get update && apt-get install -y curl  
  
# cqlsh bug workaround (from: http://stackoverflow.com/a/37291123)  
RUN rm /usr/lib/pyshared/python2.7/cqlshlib/copyutil.so  
  
ADD backup.sh /usr/app/backup.sh  
ENTRYPOINT ["/usr/app/backup.sh"]  

