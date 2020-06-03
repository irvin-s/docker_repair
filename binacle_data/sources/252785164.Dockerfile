FROM cogentlabs/spark:1.6.2  
MAINTAINER Joe Bullard <jbullard@cogent.co.jp>  
  
RUN apt-get update && \  
apt-get install -y python-pip && \  
apt-get clean && \  
rm -rf /var/lib/apt/lists/* && \  
pip install cassandra-driver  
  
# Download spark-cassandra-connector  
ADD dummy.py /  
RUN ${SPARK_HOME}/bin/spark-submit \  
\--packages com.datastax.spark:spark-cassandra-connector_2.10:1.6.2 /dummy.py  

