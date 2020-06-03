# Image: pubnative/zeppelin

FROM debian:stretch

RUN apt-get update \
  && apt-get install -y locales \
  && dpkg-reconfigure -f noninteractive locales \
  && locale-gen C.UTF-8 \
  && /usr/sbin/update-locale LANG=C.UTF-8 \
  && echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
  && locale-gen \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Users with other locales should set this in their derivative image
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN apt-get update \
  && apt-get install -y curl unzip \
    python3 python3-setuptools \
  && ln -s /usr/bin/python3 /usr/bin/python \
  && easy_install3 pip py4j \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# http://blog.stuart.axelbrooke.com/python-3-on-spark-return-of-the-pythonhashseed
ENV PYTHONHASHSEED 0
ENV PYTHONIOENCODING UTF-8
ENV PIP_DISABLE_PIP_VERSION_CHECK 1

# JAVA
ARG JAVA_MAJOR_VERSION=8
ARG JAVA_UPDATE_VERSION=181
ARG JAVA_BUILD_NUMBER=13
ENV JAVA_HOME /usr/jdk1.${JAVA_MAJOR_VERSION}.0_${JAVA_UPDATE_VERSION}

ENV PATH $PATH:$JAVA_HOME/bin
RUN curl -sL --retry 3 --insecure \
  --header "Cookie: oraclelicense=accept-securebackup-cookie;" \
  "http://download.oracle.com/otn-pub/java/jdk/${JAVA_MAJOR_VERSION}u${JAVA_UPDATE_VERSION}-b${JAVA_BUILD_NUMBER}/96a7b8442fe848ef90c96a2fad6ed6d1/server-jre-${JAVA_MAJOR_VERSION}u${JAVA_UPDATE_VERSION}-linux-x64.tar.gz" \
  | gunzip \
  | tar x -C /usr/ \
  && ln -s $JAVA_HOME /usr/java \
  && rm -rf $JAVA_HOME/man

# HADOOP
ENV HADOOP_VERSION 2.7.3
ENV HADOOP_HOME /usr/hadoop-$HADOOP_VERSION
ENV HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
ENV PATH $PATH:$HADOOP_HOME/bin
RUN curl -sL --retry 3 \
  "http://archive.apache.org/dist/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz" \
  | gunzip \
  | tar -x -C /usr/ \
  && rm -rf $HADOOP_HOME/share/doc \
  && chown -R root:root $HADOOP_HOME

# SPARK
ENV SPARK_VERSION 2.3.1
ENV SPARK_PACKAGE spark-${SPARK_VERSION}-bin-without-hadoop
ENV SPARK_HOME /usr/spark-${SPARK_VERSION}
ENV SPARK_DIST_CLASSPATH="$HADOOP_HOME/etc/hadoop/*:$HADOOP_HOME/share/hadoop/common/lib/*:$HADOOP_HOME/share/hadoop/common/*:$HADOOP_HOME/share/hadoop/hdfs/*:$HADOOP_HOME/share/hadoop/hdfs/lib/*:$HADOOP_HOME/share/hadoop/hdfs/*:$HADOOP_HOME/share/hadoop/yarn/lib/*:$HADOOP_HOME/share/hadoop/yarn/*:$HADOOP_HOME/share/hadoop/mapreduce/lib/*:$HADOOP_HOME/share/hadoop/mapreduce/*:$HADOOP_HOME/share/hadoop/tools/lib/*"
ENV PATH $PATH:${SPARK_HOME}/bin
RUN curl -sL --retry 3 \
  "https://www.apache.org/dyn/mirrors/mirrors.cgi?action=download&filename=spark/spark-${SPARK_VERSION}/${SPARK_PACKAGE}.tgz" \
  | gunzip \
  | tar x -C /usr/ \
  && mv /usr/$SPARK_PACKAGE $SPARK_HOME \
  && chown -R root:root $SPARK_HOME

WORKDIR $SPARK_HOME
CMD ["bin/spark-class", "org.apache.spark.deploy.master.Master"]

# Python packages
RUN set -ex \
  && buildDeps=' \
    libpython3-dev \
    build-essential \
    pkg-config \
    gfortran \
  ' \
  && apt-get update && apt-get install -y --no-install-recommends \
    $buildDeps \
    ca-certificates \
    wget \
    libblas-dev \
    libatlas-dev \
    liblapack-dev \
    libopenblas-dev \
    libpng-dev \
    libfreetype6-dev \
    libxft-dev \
    python3-tk \
    libxml2-dev \
    libxslt-dev \
    zlib1g-dev \
  && packages=' \
    numpy \
    pandasql \
    matplotlib \
    scipy \
  ' \
  && pip3 install $packages \
  && rm -rf /root/.cache/pip \
  && apt-get purge -y --auto-remove $buildDeps \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# R and its packages
RUN set -ex \
  && rDeps=' \
    r-base \
    r-base-dev \
    r-cran-evaluate \
  ' \
  && apt-get update && apt-get install -y --no-install-recommends $rDeps \
  && apt-get -y install r-base r-base-dev \
  && R -e "install.packages('knitr', repos='http://cran.us.r-project.org')" \
  && R -e "install.packages('ggplot2', repos='http://cran.us.r-project.org')" \
  && R -e "install.packages('googleVis', repos='http://cran.us.r-project.org')" \
  && R -e "install.packages('data.table', repos='http://cran.us.r-project.org')" \
  && apt-get -y install libcurl4-gnutls-dev libssl-dev \
  && R -e "install.packages('devtools', repos='http://cran.us.r-project.org')" \
  && R -e "install.packages('Rcpp', repos='http://cran.us.r-project.org')" \
  && Rscript -e "library('devtools'); library('Rcpp'); install_github('ramnathv/rCharts')" \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Zeppelin
ENV ZEPPELIN_PORT 8080
ENV ZEPPELIN_HOME /usr/zeppelin
ENV ZEPPELIN_CONF_DIR $ZEPPELIN_HOME/conf
ENV ZEPPELIN_NOTEBOOK_DIR $ZEPPELIN_HOME/notebook
ENV Z_VERSION 0.8.0
RUN echo '{ "allow_root": true }' > /root/.bowerrc
RUN apt-get update && apt-get install -y --no-install-recommends gnupg \
  && curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN set -ex \
  && additionalDeps=' \
    git \
    bzip2 \
    nodejs \
    npm \
    libfontconfig \
 ' \
  && apt-get update && apt-get install -y --no-install-recommends $additionalDeps \
  && wget -O /tmp/zeppelin-${Z_VERSION}-bin-all.tgz http://archive.apache.org/dist/zeppelin/zeppelin-${Z_VERSION}/zeppelin-${Z_VERSION}-bin-all.tgz \
  && tar -zxvf /tmp/zeppelin-${Z_VERSION}-bin-all.tgz \
  && rm -rf /tmp/zeppelin-${Z_VERSION}-bin-all.tgz \
  && mv ./zeppelin-${Z_VERSION}-bin-all ${ZEPPELIN_HOME}

RUN mkdir -p $ZEPPELIN_HOME/run

# Mesos
RUN echo "deb http://ftp.debian.org/debian jessie-backports main" >> /etc/apt/sources.list
RUN apt -q update && apt install -y libssl1.0.0
RUN echo 'deb http://repos.mesosphere.com/ubuntu xenial main' >> /etc/apt/sources.list.d/mesosphere.list
RUN apt-get install dirmngr && apt-key adv --keyserver keyserver.ubuntu.com --recv E56151BF \
  && apt-get -y update \
  && apt-get -y install mesos=1.3.0-2.0.3 \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

WORKDIR $ZEPPELIN_HOME
CMD ["bin/zeppelin.sh"]
