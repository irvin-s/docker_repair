FROM tutum/mysql:5.6  
RUN groupadd -r alpha \  
&& useradd -r -g alpha -G sudo alpha  
  
VOLUME ["/var/log/mysql","/tmp/seed.sql","/tmp/mysql.sock","/var/lib/mysql"]

