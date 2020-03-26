#Kaiwen Sun, A53091621
#CSE291 HW1

FROM ubuntu:latest
#FROM vaysman/jdk:jdk7
MAINTAINER Kaiwen Sun <kas003@ucsd.edu>
#ADD ./cater/ /data/.private
#ADD string.txt /data/string.txt
RUN apt-get update
#RUN apt-get install -y man
#RUN apt-get install -y vim
#RUN apt-get install -y openjdk-7-jre
#RUN apt-get install -y g++
#RUN apt-get install -y python
RUN apt-get install -y openjdk-7-jdk
