FROM python:3.6  
MAINTAINER Me <because.it.needs.atleast.1.arg>  
  
VOLUME /config  
VOLUME /code  
  
ENV TERM=xterm  
  
# install from pip  
RUN pip3 install --no-cache-dir sanic django  
  
# install utils  
RUN apt-get update && \  
apt-get install -y \  
nano  
  
# clean up  
RUN apt-get clean && \  
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
CMD [ "python", "/code/test.py" ]  

