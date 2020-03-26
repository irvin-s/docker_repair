# Dockerfile for CDH3 command
# 

FROM teco/cdh3-hadoop-base

MAINTAINER wildschu@teco.edu

ADD run.sh run.sh
ENTRYPOINT ["sh","run.sh"]