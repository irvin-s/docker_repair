FROM centos:latest  
  
RUN yum update -y && \  
yum install -y epel-release && \  
yum install -y python-dev python-pip gcc python-devel  
  
RUN pip install --upgrade pip  
RUN pip install twisted  
RUN pip install https://github.com/graphite-project/ceres/tarball/master && \  
pip install whisper && \  
pip install carbon && \  
pip install graphite-web  

