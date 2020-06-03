FROM debian:jessie  
  
WORKDIR /opt/ansible/ansible  
  
RUN \  
apt-get update  
  
RUN \  
DEBIAN_FRONTEND=noninteractive \  
&& apt-get install -y python-yaml \  
python-jinja2 \  
python-httplib2 \  
python-keyczar \  
python-paramiko \  
python-setuptools \  
python-pkg-resources \  
git \  
python-pip  
  
COPY . /opt/ansible/ansible/  
  
RUN \  
git submodule update --init  
  
ENV PYTHONPATH /opt/ansible/ansible/lib  
ENV ANSIBLE_LIBRARY /opt/ansible/ansible/library  
ENV PATH $PATH:/opt/ansible/ansible/bin  
  

