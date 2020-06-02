FROM dckreg:5000/openjdk:8-jdk

ENV HADOOP_VERSION  {{ HADOOP_VERSION }} 
ENV HADOOP_HOME        /opt/hadoop
ENV HADOOP_OPTS        -Djava.library.path=$HADOOP_HOME/lib/native
ENV PATH        $PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin

RUN DEBIAN_FRONTEND=noninteractive   && \
    wget http://archive.apache.org/dist/hadoop/core/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz && \
    tar xvf hadoop-$HADOOP_VERSION.tar.gz && \
    rm /hadoop-$HADOOP_VERSION.tar.gz && \
    mv hadoop-$HADOOP_VERSION $HADOOP_HOME 

RUN useradd -u 9000 -m hdfs

RUN mkdir /data
RUN chown -R hdfs /data

