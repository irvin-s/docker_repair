FROM monstaloc/mesos
MAINTAINER Tony Chong

EXPOSE 5051
ENTRYPOINT ["mesos-master"]