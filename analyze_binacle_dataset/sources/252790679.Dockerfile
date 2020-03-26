FROM ubuntu:14.04  
MAINTAINER Eric Shi <longwosion@gmail.com>  
  
RUN \  
sed -i 's/# \\(.*multiverse$\\)/\1/g' /etc/apt/sources.list && \  
apt-get update && \  
apt-get -y upgrade && \  
apt-get install -y build-essential && \  
apt-get install -y software-properties-common && \  
apt-get install -y byobu curl git htop man unzip vim wget && \  
rm -rf /var/lib/apt/lists/*  
  
RUN groupadd -r mysql && useradd -r -g mysql mysql  
  
# Install packages  
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \  
apt-get -y install mysql-server && \  
rm -rf /var/lib/apt/lists/*  
  
# Add MySQL configuration and scripts  
ADD config/my.cnf /etc/mysql/conf.d/my.cnf  
ADD config/mysqld_charset.cnf /etc/mysql/conf.d/mysqld_charset.cnf  
  
ADD scripts/run.sh /run.sh  
RUN chmod +x /run.sh  
  
# Define mountable directories.  
VOLUME ["/var/log/mysql/", "/var/lib/mysql", "/etc/mysql"]  
  
CMD ["/run.sh"]  
  
# Expose ports.  
EXPOSE 3306  

