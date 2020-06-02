FROM ubuntu:14.04  
MAINTAINER David Bainbridge <dbainbri@ciena.com>  
  
RUN apt-get update -y && \  
apt-get install -y python-pip  
  
RUN pip install maasclient==0.3 && \  
pip install requests_oauthlib && \  
pip install ipaddress  
  
ADD bootstrap.py /bootstrap.py  
  
ENTRYPOINT [ "/bootstrap.py" ]  

