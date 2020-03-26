FROM tomb/ubuntu:base1404

# Install basic packages
RUN apt-get install -y mysql-common
RUN apt-get install -y mysql-server
RUN apt-get install -y mysql-client

ADD my.cnf /etc/mysql/my.cnf
ADD init /init
RUN chmod 755 /init
# mysql data dir
RUN mkdir -p /home/mysql
VOLUME ["/home/mysql"]
EXPOSE 3306
EXPOSE 22
CMD /init && /usr/sbin/sshd -D
