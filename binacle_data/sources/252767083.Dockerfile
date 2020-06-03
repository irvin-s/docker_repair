FROM busybox  
  
ADD mysql /test_db/mysql  
  
VOLUME /test_db  

