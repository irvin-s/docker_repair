# sysstat
# docker run --rm -it -v $(pwd):/work supinf/sysstat:10.1 sar -f sar.data -n ALL

FROM centos:7.4.1708

RUN yum install -y sysstat

WORKDIR /work
