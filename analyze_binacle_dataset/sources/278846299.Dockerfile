FROM ubuntu:16.04

COPY requirements.txt /opt

ENV HADOOP_VERSION 2.7.3
ENV HADOOP_HOME /opt/hadoop
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV HADOOP_HDFS_HOME $HADOOP_HOME/share/hadoop/hdfs
ENV LD_LIBRARY_PATH /usr/lib/jvm/java-8-openjdk-amd64/jre/lib/amd64/server



RUN apt-get update && \
    apt-get install -y wget cmake build-essential zlib1g-dev python3 python3-pip openjdk-8-jre  && \
    pip3 install --upgrade pip

RUN pip3 install -r /opt/requirements.txt

RUN mkdir -p /opt/data_dir && \
    mkdir -p /opt/train_dir

 RUN wget -q -O /tmp/hadoop.tar.gz http://ftp-stud.hs-esslingen.de/pub/Mirrors/ftp.apache.org/dist/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz  \
    && wget -O /tmp/hadoop.asc https://dist.apache.org/repos/dist/release/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz.asc \
    && tar -xzf /tmp/hadoop.tar.gz -C /opt \
    && ln -s /opt/hadoop-$HADOOP_VERSION $HADOOP_HOME

ENV PATH="$HADOOP_HOME/sbin:$HADOOP_HOME/bin:${PATH}"
RUN mkdir /etc/hadoop && \
    mv "${HADOOP_HOME}/etc/hadoop" /etc/hadoop && ln -s /etc/hadoop "${HADOOP_HOME}/etc/hadoop"
ENV HADOOP_CONF_DIR /etc/hadoop

RUN addgroup --system hadoop \
    && adduser --home /var/lib/hadoop --ingroup hadoop --shell /bin/bash hadoop \
    && echo "hadoop:*" | chpasswd -e
RUN chown -R hadoop:hadoop $HADOOP_HOME
RUN mkdir -p /var/lib/hadoop \
    && chown -R hadoop:hadoop /var/lib/hadoop
RUN mkdir -p /var/log/hadoop \
    && chown -R hadoop:hadoop /var/log/hadoop
RUN mkdir -p /data/dfs/nn /data/dfs/dn \
    && chown -R hadoop:hadoop /data/dfs/nn /data/dfs/dn \
    && chmod 700 /data/dfs/nn /data/dfs/dn

    
# Installation process for optimized tensorflow
#RUN apt-get install -y git && \
#    git clone https://github.com/tensorflow/tensorflow && \
#    cd tensorflow && \
#    git checkout r1.2 && \
#    echo "deb [arch=amd64] http://storage.googleapis.com/bazel-apt stable jdk1.8" | sudo tee /etc/apt/sources.list.d/bazel.list && \
#    curl https://bazel.build/bazel-release.pub.gpg | sudo apt-key add - && \
#    apt-get update && sudo apt-get install bazel && \
#    ./configure && \
#    bazel build --copt=-mavx --copt=-mavx2 --copt=-mfma --copt=-msse4.2 --config=opt //tensorflow/tools/pip_package:build_pip_package && \
#    bazel-bin/tensorflow/tools/pip_package/build_pip_package /tmp/tensorflow_pkg
ADD bin /opt/tensorflow
COPY docker-entrypoint.sh /opt/tensorflow



ENTRYPOINT ["/opt/tensorflow/docker-entrypoint.sh"]