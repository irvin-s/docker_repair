FROM keensoft/centos7-java8

MAINTAINER sunzc

# set timezone to PRC
ENV TZ="Asia/Shanghai" LANG=en_US.UTF-8  PRO_ENV="prod"

ADD zhihu-spider-1.0.0.jar /home/App.jar

ENTRYPOINT java -jar /home/App.jar

