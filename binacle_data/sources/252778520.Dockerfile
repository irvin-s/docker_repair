FROM ardeveloppement/ansible:1.0  
MAINTAINER AR Developpement <support-arconnect@cospirit.com>  
  
VOLUME /etc/ansible  
  
#COPY config/openstack.yml /etc/ansible/openstack.yml  
#COPY config/openstack.py /etc/ansible/hosts  
RUN apk --update add linux-headers build-base python-dev  
RUN pip install os-client-config shade  

