FROM yancey1989/hadoop-base:1.3
 
USER root
ENV hadoops /opt/hadoops
ENV HADOOP_HOME /opt/hadoops/hadoop

COPY config/* $hadoops/hadoop/etc/hadoop/
COPY run.sh $HADOOP_HOME/run.sh
RUN chown -R hadoop ${hadoops}
RUN chmod a+x $HADOOP_HOME/run.sh
RUN apt-get install -y net-tools
# Mapred ports
EXPOSE 19888 10020

#Yarn ports
EXPOSE 8030 8031 8032 8033 8040 8042 8088 8041 8090

#timeline ports
EXPOSE 8188 8190

USER hadoop
WORKDIR $hadoops 
USER root

CMD ["/opt/hadoops/hadoop/run.sh"]
