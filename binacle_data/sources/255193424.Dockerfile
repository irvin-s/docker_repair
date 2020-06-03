FROM centos:centos7
MAINTAINER Thomas Schaffter <thomas.schaffter@gmail.com>

RUN yum install -y perl \
    wget \
    ImageMagick

# Install GNU Parallel
RUN wget http://repo.openfusion.net/centos7-x86_64/parallel-20160622-1.of.el7.x86_64.rpm && \
	rpm -Uvh parallel-20160622-1.of.el7.x86_64.rpm && rm -fr parallel-20160622-1.of.el7.x86_64.rpm

# Install dependencies for running generate_labels.py
RUN yum update -y && yum install -y epel-release && \
    yum -y group install "Development Tools" && yum install -y \
    python-devel \
    python-pip \
    numpy \
    scipy

RUN pip install --upgrade pip && \
    pip install pandas

WORKDIR /
COPY generate_image_labels.py .
COPY preprocess.sh .
