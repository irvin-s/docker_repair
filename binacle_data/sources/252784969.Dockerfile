FROM cogniteev/oracle-java:java8  
MAINTAINER coderfi@gmail.com  
  
# https://github.com/mesos/kafka  
RUN \  
apt-get update && \  
apt-get install -y git && \  
apt-get autoclean && \  
apt-get clean && \  
apt-get autoremove  
  
ENV MESOS_NATIVE_JAVA_LIBRARY /usr/local/lib/libmesos.so  
ENV KAFKA_MESOS_HOME /opt/kafka-mesos  
WORKDIR /root  
  
RUN \  
cd /tmp && \  
git clone https://github.com/mesos/kafka.git && \  
cd kafka && \  
./gradlew jar && \  
mkdir $KAFKA_MESOS_HOME && \  
cp -a kafka-mesos.sh $KAFKA_MESOS_HOME/kafka-mesos.sh && \  
mv kafka-mesos-0.9.5.0.jar $KAFKA_MESOS_HOME/. && \  
cd $KAFKA_MESOS_HOME && \  
rm -fr /root/.gradle /tmp/kafka  
  
RUN \  
cd $KAFKA_MESOS_HOME && \  
wget https://archive.apache.org/dist/kafka/0.8.2.2/kafka_2.10-0.8.2.2.tgz  
  
RUN apt-get install -y libsvn1  
RUN apt-get install -y curl  
  
COPY kafka-mesos /usr/local/bin/kafka-mesos  
  
ENTRYPOINT [ "kafka-mesos" ]  
  
COPY libmesos-0.25.0.so /usr/local/lib/libmesos.so  

