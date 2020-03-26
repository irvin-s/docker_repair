FROM openjdk:latest
ARG RELEASE=1.0.0
ENV DEBIAN_FRONTEND noninteractive
RUN wget https://github.com/EntelectChallenge/2018-TowerDefence/releases/download/${RELEASE}/starter-pack.zip -O temp.zip && \
    apt-get update && apt-get install -y sudo make && \
    adduser --disabled-password --gecos '' entelect && \
    usermod -aG sudo entelect && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
    unzip temp.zip -d /home/entelect/ && \
    rm temp.zip && \
    chown -R entelect:entelect /home/entelect/starter-pack
USER entelect
WORKDIR /home/entelect/starter-pack
