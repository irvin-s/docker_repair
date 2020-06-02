FROM alreece45/phusion-mysql-base:latest  
MAINTAINER Alexander Reece <alreece45@gmail.com>  
  
# Build packages first  
COPY ./phusion_trusty/installer /opt/mysql-installer  
RUN /opt/mysql-installer/install.sh  
  
COPY ./phusion_trusty/setup /opt/mysql-setup  
RUN /opt/mysql-setup/setup.sh \  
&& find /opt/mysql-setup -print -delete  
  
CMD ["/sbin/my_init"]  
  
EXPOSE 3306  

