FROM ubuntu:14.04

RUN apt-get update && apt-get install -y libgtk2.0-0 libcanberra-gtk-module libxext-dev libxrender-dev libxtst-dev wget

RUN export uid=1000 gid=1000 && \
    mkdir -p /home/javadev && \
    echo "javadev:x:${uid}:${gid}:JavaDev,,,:/home/javadev:/bin/bash" >> /etc/passwd && \
    echo "javadev:x:${uid}:" >> /etc/group && \
    echo "javadev ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/javadev && \
    chmod 0440 /etc/sudoers.d/javadev && \
    chown ${uid}:${gid} -R /home/javadev

USER javadev
WORKDIR /home/javadev

RUN ln -s /workspace workspace
RUN wget https://github.com/cwahl-Treeptik/jdev-env-java/releases/download/v0.1/eclipse-bin.tar && tar -xvf eclipse-bin.tar && rm eclipse-bin.tar 

ENV JAVA_HOME /opt/java-bin
ENV PATH $PATH:$JAVA_HOME/bin

CMD eclipse-bin/eclipse
