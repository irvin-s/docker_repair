FROM dooonooo/centos  
MAINTAINER dooonooo "lidongnet9@gmai.com"  
  
RUN yum -y update \  
&& yum -y install gcc pcre-devel zlib-devel make \  
&& cd /tmp \  
&& curl -O http://nginx.org/download/nginx-1.9.13.tar.gz \  
&& tar -xvf nginx-1.9.13.tar.gz \  
&& cd nginx-1.9.13 \  
&& ./configure \  
&& make \  
&& make install \  
&& yum clean all  
  
EXPOSE 80 443  
CMD ["/usr/local/nginx/sbin/nginx"]

