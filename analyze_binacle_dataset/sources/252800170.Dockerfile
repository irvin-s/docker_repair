FROM centos:7.2.1511  
RUN yum install epel-release -y && yum makecache\  
&& rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm\  
&& yum install php70w -y\  
&& yum clean all

