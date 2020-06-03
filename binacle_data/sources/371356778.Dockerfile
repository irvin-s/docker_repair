FROM yancey1989/hadoop-base:1.3
 
USER root
ENV hadoops /opt/hadoops
ENV HADOOP_HOME /opt/hadoops/hadoop

COPY config/* $hadoops/hadoop/etc/hadoop/
COPY run.sh $HADOOP_HOME/run.sh
RUN chown -R hadoop ${hadoops}
RUN chmod a+x $HADOOP_HOME/run.sh
RUN mkdir -p /opt/hdfs/namenode
RUN chown -R hadoop /opt/hdfs/namenode
RUN mkdir -p /var/lib/hadoop/dfs/data
RUN chown -R hadoop /var/lib/hadoop/dfs/data
RUN apt-get install -y net-tools
# Mapred ports
EXPOSE 50020 9000 50070 50010 50075


USER hadoop
WORKDIR $hadoops 

CMD ["/opt/hadoops/hadoop/run.sh"]
