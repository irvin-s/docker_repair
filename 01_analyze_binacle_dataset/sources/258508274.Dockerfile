FROM dckreg:5000/hbase-base:{{ HBASE_VERSION }}

ENV SPARK_VERSION     {{ SPARK_VERSION }} 
ENV SPARK_BIN_VERSION {{ SPARK_BIN_VERSION }} 
ENV SBT_VERSION       {{ SBT_VERSION }}
ENV SPARK_HOME         /opt/spark
ENV SBT_HOME           /opt/sbt
ENV PATH               $PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin:$SBT_HOME/bin

# Installing Spark for Hadoop
RUN wget http://d3kbcqa49mib13.cloudfront.net/spark-${SPARK_VERSION}-bin-without-hadoop.tgz  

RUN tar -zxf /spark-${SPARK_VERSION}-bin-without-hadoop.tgz  && \
    mv spark-${SPARK_VERSION}-bin-without-hadoop $SPARK_HOME && \
    rm /spark-${SPARK_VERSION}-bin-without-hadoop.tgz

RUN wget  https://dl.bintray.com/sbt/native-packages/sbt/$SBT_VERSION/sbt-$SBT_VERSION.tgz && \
     tar -zxf /sbt-$SBT_VERSION.tgz && \
     rm sbt-$SBT_VERSION.tgz && \
     mv /sbt* $SBT_HOME
    
RUN useradd -u 9002 -m spark 


