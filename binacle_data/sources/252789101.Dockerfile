FROM ubuntu:16.04  
  
COPY install.sh /usr/bin/install.sh  
  
RUN chmod +x /usr/bin/install.sh && bash install.sh  
  
ENV SPARK_HOME=/opt/spark \  
KAFKA_HOME=/opt/kafka \  
PYSPARK_PYTHON=/opt/anaconda/bin/python \  
PATH=/opt/anaconda/bin:/opt/jdk/bin:/usr/local/sbt/bin:/opt/spark/bin:$PATH  
  
CMD ["bash", "-c", "/usr/bin/launcher.sh"]  

