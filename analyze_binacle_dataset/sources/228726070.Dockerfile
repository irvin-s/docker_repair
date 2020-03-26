FROM ubuntu:14.04

# Replace 1000 with your user / group id
RUN export uid=1000 gid=1000 && \
    mkdir -p /home/developer && \
    echo "developer:x:${uid}:${gid}:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
    echo "developer:x:${uid}:" >> /etc/group && \
    echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
    chmod 0440 /etc/sudoers.d/developer && \
    chown ${uid}:${gid} -R /home/developer

RUN apt-get update
RUN sudo apt-get install wget zenity default-jre default-jdk -y

RUN wget https://download.jetbrains.com/webstorm/WebStorm-2016.1.1.tar.gz --no-check-certificate
RUN mv WebStorm-2016.1.1.tar.gz /opt/WebStorm.tar.gz

#COPY files/WebStorm-2016.1.1.tar.gz /opt/WebStorm.tar.gz

RUN tar -zxf /opt/WebStorm.tar.gz -C /opt/
RUN mv /opt/WebStorm-145.597.6 /opt/WebStorm
RUN ln -s /opt/WebStorm/bin/webstorm.sh /usr/bin/wstorm

WORKDIR /home/developer
USER developer
ENV HOME /home/developer

CMD wstorm

