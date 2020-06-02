FROM ubuntu-debootstrap:15.10  
MAINTAINER Wojciech Wójcik <wojtaswojcik@gmail.com>  
  
RUN apt-get update \  
&& apt-get install -yqq \  
python-minimal python-dev git python-pip sudo \  
&& pip install markupsafe ansible docker-py \  
&& apt-get -y remove python-pip python-dev \  
&& apt-get -y autoremove \  
&& apt-get -y clean \  
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \  
&& mkdir /etc/ansible/  
CMD [""]

