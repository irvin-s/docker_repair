# sysstat
# docker run --rm -it -v $(pwd):/work supinf/sysstat:9.0 sar -f sar.data -n ALL

FROM centos:6.9

RUN yum install -y sysstat

WORKDIR /work
