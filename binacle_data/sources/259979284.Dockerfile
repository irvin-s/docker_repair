FROM openjdk:7-jre
MAINTAINER xing.liu
COPY mycat /root/mycat
COPY entrypoint.sh /root/mycat/
EXPOSE 8066
VOLUME ["/root/mycat/conf"]
ENV MYCAT_HOME=/root/mycat
ENV PATH=$PATH:$MYCAT_HOME/bin
CMD ["/root/mycat/entrypoint.sh"]
