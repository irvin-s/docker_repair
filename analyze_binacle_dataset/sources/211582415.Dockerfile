#Kaiwen Sun, A53091621
#CSE291 HW1
#This Dockerfile is for dbstore, not for client and server

FROM ubuntu:latest
MAINTAINER Kaiwen Sun <kas003@ucsd.edu>
VOLUME /data
ADD ./pingpong/ /data/private/pingpong
