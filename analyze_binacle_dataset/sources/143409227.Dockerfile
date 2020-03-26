#############################################################
#       Dockerfile to build image for UFT on Centos6
#            https://github.com/supermasita/uft
#############################################################
#
# Build:
# 
# Inside "docker" dir, run:
# > sudo docker build -t "uft" . 
# 
# Run (example):
# > sudo docker run -d -p 3306:3306  \ 
# -v /host-watchfolder:/opt/uft/video-files/watchfolder \
# -v /host-output:/opt/uft/video-files/default-site-output  \ 
# --name="uft" --hostname="uft" -t uft
# 
# Accesing the container:
# > sudo docker exec -i -t uft /bin/bash
#
#            
#############################################################


FROM supermasita/docker-ffmpeg

MAINTAINER "supermasita"

ENV UFTHOME /opt

RUN yum install -y python-pip mediainfo mysql mysql-server gcc MySQL-python vim git syslog cronie

RUN pip install simple-json pymediainfo qtfaststart youtube-dl

RUN cd /opt && git clone https://github.com/supermasita/uft.git

RUN /etc/init.d/mysqld start && mysql -e "CREATE DATABASE uft; CREATE USER 'uft'@'%' IDENTIFIED BY 'uft'; GRANT ALL PRIVILEGES ON uft.* TO 'uft'@'%' WITH GRANT OPTION; FLUSH PRIVILEGES;" && mysql -D uft < $UFTHOME/uft/lib/database_structure.sql

# CRONTAB
ADD crontab.example /var/spool/cron/root

# PORTS
EXPOSE 3306 80

# RUN, FORREST! RUN!
RUN yum install -y supervisor
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
