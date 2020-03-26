FROM couchdb:1  
LABEL maintainer "Daniel Gerhardt <code@z.dgerhardt.net>"  
  
COPY usr/local/etc/couchdb/local.ini /usr/local/etc/couchdb/local.ini  

