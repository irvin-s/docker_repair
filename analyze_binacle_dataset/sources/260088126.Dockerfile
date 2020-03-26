FROM python:3.6
LABEL maintainer="LSST Alert Production; https://dm.lsst.org/"

# Pip installs.
RUN pip install 'confluent-kafka>=0.11.4'
RUN pip install avro-python3
RUN pip install Cython
RUN pip install fastavro==0.21.23
RUN pip install numpy

# Get schemas and template data.
WORKDIR /home
RUN git clone https://github.com/lsst-dm/sample-avro-alert.git

# Add code.
RUN mkdir alert_stream
ADD . /home/alert_stream
ENV PYTHONPATH=/home/alert_stream/python:/home/sample-avro-alert/python

WORKDIR /home/alert_stream
