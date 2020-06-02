FROM ubuntu:16.04  
  
ENV JAVA_HOME=/opt/jdk \  
SPARK_HOME=/opt/spark \  
LD_LIBRARY_PATH=/opt/hadoop/lib/native:$LD_LIBRARY_PATH \  
PATH=/opt/jdk/bin:/opt/scala/bin:/usr/local/sbt/bin:/opt/spark/bin:$PATH  
  
COPY install.sh /usr/bin/install.sh  
  
COPY build.sbt /root/scala/build.sbt  
  
RUN chmod +x /usr/bin/install.sh && bash install.sh  

