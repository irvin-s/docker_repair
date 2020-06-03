FROM centos:7  
ADD /contents /  
  
RUN yum -y install epel-release  
RUN yum -y install nginx python-setuptools  
RUN easy_install pip  
RUN pip install supervisor  
  
EXPOSE 80 443  
# Executing supervisord  
CMD ["supervisord", "-n"]  

