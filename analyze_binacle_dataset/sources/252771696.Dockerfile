FROM centos:7  
MAINTAINER Clement Laforet <sheepkiller@cultdeadsheep.org>  
  
RUN yum update -y && \  
yum install -y java-1.8.0-openjdk-headless && \  
yum clean all  
  
ENV JAVA_HOME=/usr/java/default/ \  
ZK_HOSTS=localhost:2181 \  
KM_CONFIGFILE="conf/application.conf"  
ADD start-kafka-manager.sh /kafka-manager/start-kafka-manager.sh  
  
RUN yum install -y java-1.8.0-openjdk-devel git wget unzip which rsync && \  
mkdir -p /tmp && \  
cd /tmp && \  
git clone https://github.com/yahoo/kafka-manager && \  
cd /tmp/kafka-manager && \  
KM_VERSION=$(awk '/^version/ { gsub(/"/,"",$NF); print $NF }' build.sbt) && \  
echo 'scalacOptions ++= Seq("-Xmax-classfile-name", "200")' >> build.sbt && \  
./sbt clean dist && \  
unzip -d / ./target/universal/kafka-manager-${KM_VERSION}.zip && \  
rsync -arv /kafka-manager-${KM_VERSION}/ /kafka-manager && \  
rm -fr /kafka-manager-${KM_VERSION} && \  
rm -fr /tmp/* /root/.sbt /root/.ivy2 && \  
chmod +x /kafka-manager/start-kafka-manager.sh && \  
yum autoremove -y java-1.8.0-openjdk-devel git wget unzip which && \  
yum clean all  
  
WORKDIR /kafka-manager  
  
EXPOSE 9000  
ENTRYPOINT ["./start-kafka-manager.sh"]  

