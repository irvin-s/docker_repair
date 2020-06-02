# Dockerfile for mysql 5.7 with support for joomla extension k2  
# acdaic4v 09.12.2015  
FROM mysql:5.7.16  
MAINTAINER acdaic4v <acdaic4v@sloervi.de>  
  
RUN /bin/echo "[mysqld]" >> /etc/mysql/my.cnf  
RUN /bin/echo "sql-mode=\"allow_invalid_dates\"" >> /etc/mysql/my.cnf  

