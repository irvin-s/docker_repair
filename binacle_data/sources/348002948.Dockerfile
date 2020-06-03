FROM ubuntu:14.04 

RUN apt-get update && apt-get install -y wget
RUN wget https://github.com/cwahl-Treeptik/jdev-env-java/releases/download/v0.1/java-bin.tar && tar -xvf java-bin.tar -C /opt && rm java-bin.tar
