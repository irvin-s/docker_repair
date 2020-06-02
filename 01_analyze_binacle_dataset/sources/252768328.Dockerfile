FROM centos  
MAINTAINER zhuyu@bimwinner.com  
RUN yum -y install curl wget net-tools  
RUN curl -L http://www.airflare.cn/tool/nginx.sh | bash  
RUN curl -L http://www.airflare.cn/tool/tomcat.sh | bash  
  
COPY services.sh /root/services.sh  
COPY nginx.conf /usr/local/nginx/conf/nginx.conf  
EXPOSE 80 8080  
ENTRYPOINT ["/root/services.sh"]  

