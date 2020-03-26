FROM ubuntu:14.04

RUN apt-get update && apt-get install -y curl libgtk2.0-0 libcanberra-gtk-module libxext-dev libxrender-dev libxtst-dev

RUN export uid=1000 gid=1000 && \
    mkdir -p /home/javadev && \
    echo "javadev:x:${uid}:${gid}:JavaDev,,,:/home/javadev:/bin/bash" >> /etc/passwd && \
    echo "javadev:x:${uid}:" >> /etc/group && \
    echo "javadev ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/javadev && \
    chmod 0440 /etc/sudoers.d/javadev && \
    chown ${uid}:${gid} -R /home/javadev

RUN apt-get install -y xvfb x11vnc fluxbox

ENV JAVA_HOME=/opt/java-bin
ENV PATH=$JAVA_HOME/bin:$PATH
ENV DISPLAY :1

USER javadev
WORKDIR /home/javadev

RUN curl -fSL "http://www.eclipse.org/downloads/download.php?file=/technology/epp/downloads/release/luna/R/eclipse-jee-luna-R-linux-gtk-x86_64.tar.gz&r=1" -o eclipse.tar.gz \
	&& tar -xvf eclipse.tar.gz && rm eclipse.tar.gz

CMD Xvfb :1 -screen 0 1920x1080x16 & fluxbox & sleep 10 && x11vnc -forever& sleep 10 && eclipse/eclipse
