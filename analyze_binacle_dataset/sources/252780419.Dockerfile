FROM centos:6  
MAINTAINER takaaki@cayto.jp  
  
# install  
RUN yum install -y java-1.8.0-openjdk-devel.x86_64 | true  
RUN yum install -y git | true && yum clean all  
  
# settings  
# lang  
COPY conf/i18n /etc/sysconfig/  
RUN source /etc/sysconfig/i18n && localedef -f UTF-8 -i ja_JP ja_JP.UTF-8  
  
# clock  
COPY conf/clock /etc/sysconfig/  
RUN source /etc/sysconfig/clock  
RUN \cp -p -f /usr/share/zoneinfo/Asia/Tokyo /etc/localtime  
  
# gitbucket  
COPY conf/gitbucket/gitbucket.sh /etc/init.d/gitbucket  
COPY conf/gitbucket/gitbucket.conf /etc/sysconfig/gitbucket  
  
# services  
COPY conf/services.sh /etc/  
  
RUN chmod 777 -R /opt/ && \  
chmod 777 /etc/init.d/gitbucket && \  
chmod 777 /etc/services.sh  
  
# ポート開放  
EXPOSE 8080  
# war  
COPY conf/gitbucket/gitbucket.war /opt/  
  
# 起動時  
ENTRYPOINT /etc/services.sh  

