# Dockerfile for CDH3 slave
# 

FROM teco/cdh3-hadoop-base

MAINTAINER wildschu@teco.edu

# Datanode
EXPOSE 50010:50010 1004:1004 50075:50075 50475:50475 1006:1006 50020:50020

# Tasktracker
EXPOSE 50060:50060

ADD run.sh run.sh
ENTRYPOINT ["sh","run.sh"]