FROM klaemo/couchdb:1.6.1  
MAINTAINER tomas.bouda@purposefly.com  
  
# custom setup  
ADD etc /usr/local/etc/couchdb/local.d  

