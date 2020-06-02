FROM trex/hadoop-base:latest
MAINTAINER xenron <xenron@hotmail.com>

# move all confugration /tmp into container
ADD files/hadoop/* /tmp/

ENV HADOOP_INSTALL /opt/hadoop

#RUN mkdir $HADOOP_INSTALL/logs

RUN mv /tmp/hdfs-site.xml $HADOOP_INSTALL/etc/hadoop/hdfs-site.xml && \
mv /tmp/core-site.xml $HADOOP_INSTALL/etc/hadoop/core-site.xml && \
mv /tmp/mapred-site.xml $HADOOP_INSTALL/etc/hadoop/mapred-site.xml && \
mv /tmp/yarn-site.xml $HADOOP_INSTALL/etc/hadoop/yarn-site.xml

# RUN mv /tmp/start-sshd.sh ~/start-sshd.sh && \
# chmod +x ~/start-sshd.sh

EXPOSE 22 7373 7946 9000 50010 50020 50070 50075 50090 50475 8030 8031 8032 8033 8040 8042 8060 8088 50060

# CMD '/root/start-sshd.sh'; 'bash'
# CMD 'bash'
# CMD ["tail", "-f", "/dev/null"]
# ENTRYPOINT ["sh", "/opt/start-sshd.sh"]
# CMD [ "sh", "-c", "service sshd start; bash"]
# ENTRYPOINT ["sh", "/etc/init.d/ssh start -D"]
ENTRYPOINT ["sh", "/etc/init.d/ssh", "start", "-D"]

