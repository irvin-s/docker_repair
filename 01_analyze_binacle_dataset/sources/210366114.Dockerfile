FROM index.tenxcloud.com/google_containers/spark-driver:1.5.2_v1

ADD spark-cassandra-connector-java-assembly-1.5.0.jar /
ADD spark-defaults.conf /

RUN cp -f spark-defaults.conf /opt/spark/conf
