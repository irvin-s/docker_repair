FROM centos  
RUN yum -y install hyperv-daemons  
CMD hypervfcopyd && hypervkvpd && hypervvssd && sleep infinity

