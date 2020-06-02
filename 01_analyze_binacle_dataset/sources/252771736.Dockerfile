# A more verbose version sylvainlasnier's memcached Docker repository  
FROM sylvainlasnier/memcached:latest  
  
CMD ["/usr/bin/memcached", "-u", "memcache", "-vv"]  

