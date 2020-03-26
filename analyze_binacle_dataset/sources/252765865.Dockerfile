FROM 410labs/graphite:1.1.1  
EXPOSE 2003-2004  
CMD /usr/bin/python /opt/graphite/bin/carbon-cache.py start --debug  
  
# don't forget to share the storage volume with and link to graphite container  

