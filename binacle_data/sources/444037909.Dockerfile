FROM xeor/base-centos

MAINTAINER Lars Solberg <lars.solberg@gmail.com>
ENV REFRESHED_AT 2014-12-18

RUN yum install -y iperf3

EXPOSE 5201
CMD ["/usr/bin/iperf3", "-i", "5", "-B", "0.0.0.0", "-V", "-s"]
