# docker image creation for slimta/debian  
FROM debian:latest  
MAINTAINER David G.R.C. Furminieux  
  
# configure which ports will be exposed  
EXPOSE 25  
EXPOSE 587  
# define environment variables  
ENV REDIS_URL redis://localhost/  
ENV REDIS_TARGET mails-topic  
ENV REDIS_TARGET_TYPE -t  
ENV MTA_PORTS="25 587"  
# update and upgrade the system!  
RUN apt-get update && apt-get upgrade -y  
  
# install dependencies  
# RUN apt-get install -y apt-utils  
RUN apt-get install -y \  
git \  
python-pip \  
python-setuptools-git \  
python-redis \  
libpython-dev \  
supervisor \  
jed \  
net-tools  
  
RUN pip install \  
git+https://github.com/abusix/python-slimta.git@develop#egg=slimta  
  
# add supervisor configs  
ADD supervisor.conf /etc/supervisor/conf.d/slimta.conf  
  
CMD ["/usr/bin/supervisord","-n", "-c","/etc/supervisor/supervisord.conf"]  

