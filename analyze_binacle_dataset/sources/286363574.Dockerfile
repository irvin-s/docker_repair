FROM ubuntu:16.04

RUN sed -i "s/http:\/\/archive.ubuntu.com/http:\/\/mirrors.tuna.tsinghua.edu.cn/g" /etc/apt/sources.list
RUN sed -i "s/http:\/\/security.ubuntu.com/http:\/\/mirrors.tuna.tsinghua.edu.cn/g" /etc/apt/sources.list


RUN apt-get update && apt-get -y dist-upgrade
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y mysql-server
RUN apt-get install -y python python-pip python-dev libmysqld-dev git ssh lib32z1 vim
RUN pip install -i https://pypi.tuna.tsinghua.edu.cn/simple mysql-python serial dpkt requests



RUN chown -R mysql:mysql /var/lib/mysql && \
    service mysql start &&\  
    mysql -e "grant all privileges on *.* to 'root'@'%' identified by 'k8aVBK10R1L3';"&&\  
    mysql -e "grant all privileges on *.* to 'root'@'localhost' identified by 'k8aVBK10R1L3';"&&\ 
    mysql -u root -pk8aVBK10R1L3 -e "CREATE USER 'explorer'@'localhost' IDENTIFIED BY 'VsJ5DU6PjNh7';"&&\ 
    mysql -u root -pk8aVBK10R1L3 -e "CREATE DATABASE pwnlog;"&&\ 
    mysql -u root -pk8aVBK10R1L3 -e "GRANT ALL ON pwnlog.* TO 'explorer'@'localhost';"&&\ 
    mysql -u root -pk8aVBK10R1L3 -e "flush PRIVILEGES"

WORKDIR /root
RUN mkdir -p .ssh
RUN echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDZvJ+4M3USfEibSMzEnsEfwDVLuub472siyBIg2ULBNMXjJNHsYUXxGFQhFdEkSgseH4YFB5UjHrxRTavAwLBS9X6M45/4JY/B0BlVbqXdFwNGjFQCm4mpockFnFmScpnPtVEtXdfY4wnZSQ32JEh6msBzP3IP0uAbrnxoyIrxfeuGlZQARhuITFqwv8CcpAfH4pnrXMKHIa9sOOBKZ7ln5AKQWuOA4+Np+6dVT0pQ6lxtUohuovLDkH+f0r2Q4HBI0n8NUfiN9hFDGgrYsybtcqnAgzc3DUerIdCTK0iQqv9BPN64L2IwarM21ZceAy1AkbDEEtjIYhBIVsiC7Hxh explorer@explorer-pc" > ./.ssh/authorized_keys

RUN git clone https://github.com/zh-explorer/black_zone.git
RUN mkdir /home/pwn

COPY ./bin/ /root/bin/
COPY ./zone.py /root/black_zone/


CMD service ssh start && chown -R mysql:mysql /var/lib/mysql && service mysql start && sleep infinity

EXPOSE 12345
EXPOSE 22


