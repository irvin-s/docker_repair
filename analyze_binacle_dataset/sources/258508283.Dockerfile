FROM dckreg:5000/spark-base:{{ SPARK_VERSION }}

RUN apt-get  update
RUN apt-get install -y python-software-properties 


ENV ZEPPELIN_VERSION      {{ ZEPPELIN_VERSION }}
ENV ZEPPELIN_HOME         /opt/zeppelin
ENV PATH               $PATH:$ZEPPELIN_HOME/bin

RUN wget http://apache.cs.utah.edu/zeppelin/zeppelin-$ZEPPELIN_VERSION/zeppelin-$ZEPPELIN_VERSION-bin-all.tgz 

RUN tar -zxf /zeppelin-$ZEPPELIN_VERSION-bin-all.tgz -C /opt/ && \
    ln -s /opt/zeppelin-$ZEPPELIN_VERSION-bin-all $ZEPPELIN_HOME && \
    rm /zeppelin-$ZEPPELIN_VERSION-bin-all.tgz

RUN cp /opt/phoenix/phoenix-4.9.0-HBase-1.2-client.jar $ZEPPELIN_HOME/interpreter/jdbc/

