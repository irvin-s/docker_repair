# CloudStack {{ cloudstack_version }} Management Server installation
# VERSION {{ cloudstack_version }}

FROM ubuntu:14.04
MAINTAINER Jeff Moody "fifthecho@gmail.com"

# initial settings
ENV DEBIAN_FRONTEND noninteractive
RUN echo 'root:cloudstack' | chpasswd
RUN apt-get update
RUN apt-get install -y wget curl sudo nano vim
# RUN groupadd -g 27 sudo
RUN useradd -s /bin/bash -m -k -U cloudstack
RUN usermod -a -G sudo cloudstack
RUN echo 'cloudstack:{{ cloud_user_password }}' | chpasswd

# setting up CloudStack build environment
RUN apt-get install -y git maven openjdk-7-jdk python-pip python-dev python-setuptools mkisofs
RUN sudo -u cloudstack git clone https://github.com/apache/cloudstack.git -b {{ cloudstack_version }} /home/cloudstack/cloudstack
RUN sudo -u cloudstack wget http://download.cloud.com.s3.amazonaws.com/tools/vhd-util -O /home/cloudstack/cloudstack/scripts/vm/hypervisor/xenserver/vhd-util
ADD build/build-cloudstack.sh /home/cloudstack/build-cloudstack.sh
RUN chown cloudstack:cloudstack /home/cloudstack/*.sh
RUN chmod +x /home/cloudstack/*.sh
RUN sudo -u cloudstack /home/cloudstack/build-cloudstack.sh


# settings for supervisord
RUN apt-get install -y openssh-server mysql-server supervisor net-tools
RUN mkdir /var/run/sshd/
RUN mkdir -p /var/log/supervisor/
RUN mkdir -p /etc/supervisor/conf.d/
ADD build/supervisord.conf /etc/supervisor/conf.d/

# mysql configuration
ADD build/my.cnf /etc/mysql/
RUN (/usr/bin/mysqld_safe &); sleep 5; echo "DELETE FROM mysql.user WHERE host='::1';SET PASSWORD FOR root@localhost = PASSWORD('{{ mysql_root_password }}'); GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '{{ mysql_root_password }}' WITH GRANT OPTION; FLUSH PRIVILEGES;" | mysql -uroot

# Add Supervisord web interface for log files.
ADD build/supervisor-interface.conf /etc/supervisor/conf.d/

# create directories for storage
RUN mkdir -p /opt/storage/primary
RUN mkdir -p /opt/storage/secondary

# port expose
EXPOSE 22
EXPOSE 3306
EXPOSE 8080 8250 3922 9090 7080
EXPOSE 9001

# CMD execution
CMD "/usr/bin/supervisord"
