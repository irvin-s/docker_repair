FROM ubuntu:trusty

ENV HOME /root
ENV DEBIAN_FRONTEND noninteractive

RUN \
    apt-get update && \
    apt-get install -y python python-pip python-dev make curl jq wget unzip libmysqlclient-dev && \
    pip install unicodecsv && \
    pip install MySQL-python && \
    apt-get remove -y --auto-remove gcc python-pip python-dev make libmysqlclient-dev && \
    apt-get clean -y && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD ./freebase_data /freebase_data
ADD ./scripts /movielens/scripts

# Define default command.
CMD ["bash"]
