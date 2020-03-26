FROM babim/mariadb:10.3  
# user  
RUN usermod -u 66 mysql && groupmod -g 66 mysql

