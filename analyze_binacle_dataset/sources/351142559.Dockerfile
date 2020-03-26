FROM centos:centos7
MAINTAINER Joe Block "jpb@numenta.com"
ENV CREATION_DATE 2014-12-01_1437

RUN mkdir -p /usr/local/bin

# We need EPEL to install pip
RUN yum install epel-release -y && yum install -y python-pip

# Update yum
RUN yum update -y

# Burnrate depends on grokcli & boto
RUN pip install grokcli boto

VOLUME /metrics

# Install our code
COPY burnrate_collect_data.py /usr/local/bin/burnrate_collect_data
COPY calculate_burn_rate.py /usr/local/bin/calculate_burn_rate.py
COPY burnrate-metric /usr/local/bin/burnrate-metric

RUN chmod +x /usr/local/bin/burnrate_collect_data \
  /usr/local/bin/calculate_burn_rate.py \
  /usr/local/bin/burnrate-metric
