FROM ubuntu:14.04.2
MAINTAINER peachstone.io

RUN apt-get update
# Not recommended:    apt-get upgrade -y 

RUN apt-get -y install curl \
  wget

# Install Oracle Java 8
RUN apt-get -y install software-properties-common
RUN add-apt-repository ppa:webupd8team/java
RUN apt-get -y update
RUN echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 boolean true" | debconf-set-selections 
RUN apt-get -y install oracle-java8-installer
RUN update-alternatives --display java

# Install Spark
RUN curl -s http://ftp.halifax.rwth-aachen.de/apache/spark/spark-1.3.1/spark-1.3.1-bin-hadoop2.6.tgz | tar -xz -C /usr/local/
RUN cd /usr/local && ln -s spark-1.3.1-bin-hadoop2.6 spark
ENV SPARK_HOME /usr/local/spark

# Install Python
# RUN wget http://repo.continuum.io/miniconda/Miniconda-latest-Linux-x86_64.sh
# RUN chmod 700 Miniconda-latest-Linux-x86_64.sh

RUN echo 'export PATH=/usr/local/share/conda/bin:$PATH' > /etc/profile.d/conda.sh
RUN wget --quiet http://repo.continuum.io/miniconda/Miniconda-latest-Linux-x86_64.sh
RUN /bin/bash /Miniconda-latest-Linux-x86_64.sh -b -p /usr/local/share/conda
RUN rm Miniconda-latest-Linux-x86_64.sh
RUN /usr/local/share/conda/bin/conda install --yes conda==3.9.0

ENV PATH /usr/local/share/conda/bin:$PATH

RUN conda install -y pip 
RUN pip install py4j
