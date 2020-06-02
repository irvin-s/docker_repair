FROM monstaloc/mesos
MAINTAINER Tony Chong

# This script will start the docker service and run the mesos-slave
# apparently you need docker running in the background as an executor
ADD start.sh /tmp/start.sh

EXPOSE 5051
ENTRYPOINT ["/tmp/start.sh"]