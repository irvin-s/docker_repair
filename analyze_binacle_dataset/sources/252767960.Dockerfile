FROM centos:7.1.1503  
ENV PATH $PATH:/  
RUN yum install -y glibc.i686 && yum clean all  
RUN rpm -Uvh http://pkgs.repoforge.org/stress/stress-1.0.2-1.el7.rf.x86_64.rpm  
ADD super_pi /super_pi  
ADD pi /pi  
RUN chmod a+x /super_pi  

