FROM mysql/mysql-server:5.7  
MAINTAINER Danil Agafonov <mail@live-notes.ru>  
  
COPY minimal.cnf /etc/my.cnf.d/  
RUN /bin/bash -c 'echo "!includedir /etc/my.cnf.d" >> /etc/my.cnf'  

