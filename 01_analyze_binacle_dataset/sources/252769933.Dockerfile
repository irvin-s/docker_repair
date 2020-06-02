FROM mysql:8  
RUN echo "[mysqld]\n"\  
"bind-address = 0.0.0.0" >> /etc/mysql/conf.d/bindall.cnf  

