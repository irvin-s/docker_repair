FROM centos:6.6  
MAINTAINER Brian Brietzke "bbrietzke@gmail.com"  
EXPOSE 2812  
RUN yum install -y epel-release \  
&& yum install -y deltarpm psmisc wget \  
&& rpm -ivh http://pkgs.repoforge.org/monit/monit-5.5-1.el6.rf.x86_64.rpm \  
&& yum clean all  
  
ADD etc /etc  
  
RUN chmod 700 /etc/monit.conf  
  
ENTRYPOINT ["/usr/bin/monit", "-Ic", "/etc/monit.conf"]  

