FROM damsl/k3-deployment:latest

# Locale
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Dependencies
RUN apt-get update && apt-get install -y git vim wget python postgresql-client-9.3 python-psycopg2 python-matplotlib xvfb libaio-dev unzip

# Java
RUN sed 's/main$/main universe/' -i /etc/apt/sources.list
RUN apt-get update && apt-get install -y software-properties-common python-software-properties
RUN add-apt-repository ppa:webupd8team/java -y

RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections

RUN apt-get update && apt-get install -y oracle-java7-installer
ENV JAVA_HOME /usr/lib/jvm/java-7-oracle/

# Install Scala
WORKDIR /software
RUN wget http://www.scala-lang.org/files/archive/scala-2.10.4.tgz
RUN tar -xvzf scala-2.10.4.tgz
ENV SCALA_HOME /software/scala-2.10.4/bin/

# Install Spark
RUN wget http://d3kbcqa49mib13.cloudfront.net/spark-1.2.0.tgz && tar -xvzf spark-1.2.0.tgz
WORKDIR /software/spark-1.2.0
RUN sbt/sbt -Dhadoop.version=2.2.0 -Pyarn -Phive assembly/assembly

WORKDIR /software

ADD sbt /usr/bin/
RUN wget https://dl.bintray.com/sbt/native-packages/sbt/0.13.7/sbt-0.13.7.tgz && \
    tar -xvzf sbt-0.13.7.tgz && \
    mv sbt/bin/sbt-launch.jar /usr/bin/
RUN chmod +x /usr/bin/sbt
RUN sbt

ENV SPARK_HOME /software/spark-1.1.0-bin-hadoop2.4/

# Impala
WORKDIR /
RUN wget http://archive.cloudera.com/cdh5/one-click-install/trusty/amd64/cdh5-repository_1.0_all.deb && \
    dpkg -i cdh5-repository_1.0_all.deb && \ 
    apt-get update && \ 
    apt-get install -y impala-shell

# Vertica
ADD vertica-client-7.1.1-0.linux.x86_64.tar.gz /software/
RUN ln -s /software/opt/vertica/bin/vsql /usr/bin/vsql

# Oracle
ADD instantclient-basic-linux.x64-12.1.0.2.0.zip  /oracle/
ADD instantclient-sqlplus-linux.x64-12.1.0.2.0.zip /oracle/
WORKDIR /oracle
RUN unzip instantclient-basic-linux.x64-12.1.0.2.0.zip && \
    unzip instantclient-sqlplus-linux.x64-12.1.0.2.0.zip && \
    ln -s /oracle/instantclient_12_1/sqlplus /usr/bin/sqlplus
ENV LD_LIBRARY_PATH /oracle/instantclient_12_1/

# Mesos
WORKDIR /software
RUN apt-get install -y build-essential python-dev python-boto libcurl4-nss-dev libsasl2-dev maven libapr1-dev libsvn-dev autoconf libtool && \
    wget http://archive.apache.org/dist/mesos/0.21.0/mesos-0.21.0.tar.gz && \
    tar -zxf mesos-0.21.0.tar.gz && \
    apt-get install -y gcc-4.6 && \
    update-alternatives --remove-all gcc && \
    apt-get install -y gcc-4.6 g++-4.6 && \
    update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.6 10 && \
    update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-4.6 10 && \
    
    cd mesos-0.21.0 && mkdir build && cd build && ../configure && make && make install && \
    update-alternatives --remove-all gcc && update-alternatives --remove-all g++ && \
    update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.9 10 && \
    update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-4.9 10 && \
    apt-get install -y libprotobuf-dev libgoogle-glog-dev

WORKDIR /
RUN git clone https://github.com/damsl/k3-benchstack
ADD entrypoint.sh /
RUN chmod +x /entrypoint.sh

RUN apt-get install -y cmake python-pip
RUN pip install pyyaml docker-py

ENTRYPOINT ["/entrypoint.sh"]
