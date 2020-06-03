FROM centos:centos7  
MAINTAINER levm <av@levm.eu>  
  
RUN yum -y update; yum clean all  
RUN yum -y install epel-release tar ; yum clean all  
RUN yum -y install python-pip python-pycurl;  
RUN adduser shinken  
RUN pip install shinken  
  
RUN /usr/bin/shinken-scheduler -d -c /etc/shinken/daemons/schedulerd.ini  
RUN /usr/bin/shinken-poller -d -c /etc/shinken/daemons/pollerd.ini  
RUN /usr/bin/shinken-reactionner -d -c /etc/shinken/daemons/reactionnerd.ini  
RUN /usr/bin/shinken-broker -d -c /etc/shinken/daemons/brokerd.ini  
RUN /usr/bin/shinken-arbiter -d -c /etc/shinken/shinken.cfg  
  
ENTRYPOINT ["bash"]

