
FROM jenkins:latest
MAINTAINER tomsun28 <usthe.com>
#安装jenkins插件
USER jenkins
COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/plugins.txt

USER root
ARG dockerGid=999

#将jenkins用户放docker组,安装gosu
RUN echo "docker:x:${dockerGid}:jenkins" >> /etc/group \ 
    && apt-get update &&  apt-get install -y gosu \
    && apt-get install -y libltdl7 \
    && rm -rf /var/lib/apt/list/*


COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
