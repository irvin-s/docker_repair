FROM debian:wheezy  
MAINTAINER cocoon  
  
#  
# an ansible ready debian wheezy base image  
#  
# update apt cache  
RUN apt-get -y update && apt-get -y upgrade  
  
# install git and vim  
RUN apt-get -y --no-install-recommends install git vim  
ADD files/vimrc /.vimrc  
  
# Install Python.  
RUN apt-get -y install python-dev python-yaml \  
python-setuptools \  
python-pkg-resources python-pip  
  
# install ansible  
RUN mkdir -p /etc/ansible/ && echo '[local]\nlocalhost\n' > /etc/ansible/hosts  
RUN pip install ansible  
  
# clean  
#RUN apt-get purge -y python2.6 python2.6-minimal \  
RUN apt-get clean  
RUN rm -rf /var/lib/apt/lists/*  
  
# Define working directory.  
WORKDIR /data  
  
# Define default command.  
CMD ["bash"]  

