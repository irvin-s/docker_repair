FROM ubuntu:16.04
MAINTAINER ramon@wartala.de

RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        curl \
        cmake \
        git \
        wget \
        libatlas-base-dev \
        libboost-all-dev \
        libfreetype6-dev \
        libgflags-dev \
        libgoogle-glog-dev \
        libhdf5-serial-dev \
        libleveldb-dev \
        liblmdb-dev \
        libopencv-dev \
        libpng12-dev \
        libzmq3-dev \
        libprotobuf-dev \
        libsnappy-dev \
        pkg-config \
        protobuf-compiler \
        rsync \
        software-properties-common \
        unzip \
        groff \
        vim \
        zlib1g-dev \
        python-pydot \
        && \
    apt-get clean && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/*

RUN curl -O https://bootstrap.pypa.io/get-pip.py && \
    python get-pip.py && \
    rm get-pip.py

#RUN pip --no-cache-dir install \
#		pyopenssl \
#		ndg-httpsclient \
#		pyasn1

RUN apt-get update && apt-get install -y \
		python-numpy \
		python-scipy \
		python-nose \
		python-h5py \
		python-skimage \
		python-matplotlib \
		python-pandas \
		python-sklearn \
		python-sympy \
    python-skimage \
    python-progressbar \
		&& \
	apt-get clean && \
	apt-get autoremove && \
	rm -rf /var/lib/apt/lists/*

RUN pip --no-cache-dir install --upgrade ipython && \
	pip --no-cache-dir install \
		Cython \
		ipykernel \
		jupyter \
		path.py \
		Pillow \
		pygments \
		six \
		sphinx \
		wheel \
		zmq \
        protobuf \
        future \
		&& \
	python -m ipykernel.kernelspec


# Install Caffe
RUN echo "Installiere Caffe..."
ENV CAFFE_ROOT=/opt/caffe
WORKDIR $CAFFE_ROOT

# FIXME: use ARG instead of ENV once DockerHub supports this
# https://github.com/docker/hub-feedback/issues/460
ENV CLONE_TAG=1.0

RUN git clone -b ${CLONE_TAG} --depth 1 https://github.com/BVLC/caffe.git . && \
    cd python && for req in $(cat requirements.txt) pydot; do pip install $req; done && cd .. && \
    mkdir build && cd build && \
    cmake -DCPU_ONLY=1 .. && \
    make -j"$(nproc)"

# Install Caffe2
RUN echo "Installiere Caffe2..."
ENV CAFFE2_ROOT /opt
WORKDIR $CAFFE2_ROOT
RUN cd $CAFFE2_ROOT

RUN git clone https://github.com/caffe2/caffe2.git \
    && cd caffe2 \
    && git submodule deinit -f  third_party/cub \
    && rm -rf .git/modules/third_party/cub \
    && git rm -f third_party/cub \
    && git submodule update --recursive --remote \
    && git submodule update --init \ 
    && mkdir build && cd build \
    && cmake .. \
    -DUSE_CUDA=OFF \
    -DUSE_NNPACK=OFF \
    -DUSE_ROCKSDB=OFF \
    && make -j"$(nproc)" install \
    && ldconfig \
    #&& make clean \
    && cd .. \
    #&& rm -rf build

#RUN git clone --recursive https://github.com/caffe2/caffe2.git && \

RUN pip install --upgrade pip \
    && pip install numpy protobuf hypothesis tflearn

########## INSTALLATION STEPS ###################
#RUN cd caffe2 && \
#    make && \
#    cd build && \
#    make install

ENV PYTHONPATH /usr/local
ENV LD_LIBRARY_PATH /usr/local/lib:$LD_LIBRARY_PATH
RUN python -c 'from caffe2.python import core' 2>/dev/null && echo "Success" || echo "Failure"


# Install TensorFlow
RUN echo "Installiere TensorFlow..."

ARG TENSORFLOW_VERSION=1.1.0
ARG TENSORFLOW_ARCH=cpu

# Install TensorFlow
RUN pip --no-cache-dir install \
	https://storage.googleapis.com/tensorflow/linux/${TENSORFLOW_ARCH}/tensorflow-${TENSORFLOW_VERSION}-cp27-none-linux_x86_64.whl

# Install Java
RUN echo "Installiere Java 8..."
ARG JAVA_MAJOR_VERSION=8
ARG JAVA_UPDATE_VERSION=131
ARG JAVA_BUILD_NUMBER=11
ENV JAVA_HOME /usr/jdk1.${JAVA_MAJOR_VERSION}.0_${JAVA_UPDATE_VERSION}

ENV PATH $PATH:$JAVA_HOME/bin
RUN curl -sL --retry 3 --insecure \
  --header "Cookie: oraclelicense=accept-securebackup-cookie;" \
  "http://download.oracle.com/otn-pub/java/jdk/${JAVA_MAJOR_VERSION}u${JAVA_UPDATE_VERSION}-b${JAVA_BUILD_NUMBER}/d54c1d3a095b4ff2b6607d096fa80163/server-jre-${JAVA_MAJOR_VERSION}u${JAVA_UPDATE_VERSION}-linux-x64.tar.gz" \
  | gunzip \
  | tar x -C /usr/ \
  && ln -s $JAVA_HOME /usr/java \
  && rm -rf $JAVA_HOME/man

# Install HADOOP
RUN echo "Installiere Hadoop..."
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

# Install SPARK
RUN echo "Installiere Spark..."
ENV SPARK_VERSION 2.1.1
ENV SPARK_PACKAGE spark-${SPARK_VERSION}-bin-without-hadoop
ENV SPARK_HOME /usr/spark-${SPARK_VERSION}
ENV SPARK_DIST_CLASSPATH="$HADOOP_HOME/etc/hadoop/*:$HADOOP_HOME/share/hadoop/common/lib/*:$HADOOP_HOME/share/hadoop/common/*:$HADOOP_HOME/share/hadoop/hdfs/*:$HADOOP_HOME/share/hadoop/hdfs/lib/*:$HADOOP_HOME/share/hadoop/hdfs/*:$HADOOP_HOME/share/hadoop/yarn/lib/*:$HADOOP_HOME/share/hadoop/yarn/*:$HADOOP_HOME/share/hadoop/mapreduce/lib/*:$HADOOP_HOME/share/hadoop/mapreduce/*:$HADOOP_HOME/share/hadoop/tools/lib/*"
ENV PATH $PATH:${SPARK_HOME}/bin
RUN curl -sL --retry 3 \
  "http://d3kbcqa49mib13.cloudfront.net/${SPARK_PACKAGE}.tgz" \
  | gunzip \
  | tar x -C /usr/ \
 && mv /usr/$SPARK_PACKAGE $SPARK_HOME \
 && chown -R root:root $SPARK_HOME

# Install BigDL
RUN echo "Installiere BigDL..."
RUN pip --no-cache-dir install BigDL==0.2.0 \
  seaborn \
  wordcloud

# Install awscli
RUN echo "Installiere awscli..."
RUN pip --no-cache-dir install awscli

# Install google cloud SDK
RUN echo "Installiere Google Cloud SDK..."
ENV CLOUD_SDK_VERSION 165.0.0

RUN apt-get -qqy update && apt-get install -qqy \
        curl \
        gcc \
        python-dev \
        python-setuptools \
        apt-transport-https \
        lsb-release \
        openssh-client \
        git \
    && easy_install -U pip && \
    pip install -U crcmod   && \
    export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)" && \
    echo "deb https://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" > /etc/apt/sources.list.d/google-cloud-sdk.list && \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
    apt-get update && \
    apt-get install -y google-cloud-sdk=${CLOUD_SDK_VERSION}-0 \
        google-cloud-sdk-app-engine-python \
        google-cloud-sdk-app-engine-java \
        google-cloud-sdk-app-engine-go \
        google-cloud-sdk-datalab \
        google-cloud-sdk-datastore-emulator \
        google-cloud-sdk-pubsub-emulator \
        google-cloud-sdk-bigtable-emulator \
        google-cloud-sdk-cbt \
        kubectl && \
    gcloud config set core/disable_usage_reporting true && \
    gcloud config set component_manager/disable_update_check true && \
    gcloud config set metrics/environment github_docker_image

# Install SparkNet
RUN echo "Installiere SparkNet..."
WORKDIR /opt
RUN git clone https://github.com/amplab/SparkNet.git
ENV SPARKNET_HOME=/opt/SparkNet
WORKDIR $SPARKNET_HOME
RUN echo "deb https://dl.bintray.com/sbt/debian /" | tee -a /etc/apt/sources.list.d/sbt.list
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2EE0EA64E40A89B84B2DF73499E82A75642AC823
RUN apt-get update
RUN apt-get install sbt

# Set up our notebook config.
COPY jupyter_notebook_config.py /root/.jupyter/

# Copy sample notebooks.
RUN mkdir /root/notebooks
RUN mkdir /root/notebooks/kapitel1
RUN mkdir /root/notebooks/kapitel2
RUN mkdir /root/notebooks/kapitel3
RUN mkdir /root/notebooks/kapitel4
RUN mkdir /root/notebooks/kapitel5
RUN mkdir /root/notebooks/kapitel6
RUN mkdir /root/notebooks/kapitel7
RUN mkdir /root/notebooks/kapitel8

#COPY notebooks/kapitel1/* /root/notebooks/kapitel1/
#COPY notebooks/kapitel2/* /root/notebooks/kapitel2/
#COPY notebooks/kapitel3/* /root/notebooks/kapitel3/
COPY notebooks/kapitel4/* /root/notebooks/kapitel4/
COPY notebooks/kapitel5/* /root/notebooks/kapitel5/
COPY notebooks/kapitel6/* /root/notebooks/kapitel6/
#COPY notebooks/kapitel7/* /root/notebooks/kapitel7/
#COPY notebooks/kapitel8/* /root/notebooks/kapitel8/


# Jupyter has issues with being run directly:
#   https://github.com/ipython/ipython/issues/7062
# We just add a little wrapper script.
COPY run_jupyter.sh /root/

# TensorBoard port
RUN echo "TensorBoard nutzt Port 6006..."
EXPOSE 6006

RUN echo "Jupyter Notebook startet auf Port 8888..."
EXPOSE 8888

RUN echo "SparkUI nutzt Port 4040 und 4041..."
EXPOSE 4040
EXPOSE 4041

WORKDIR "/root"
CMD ["/bin/bash"]
