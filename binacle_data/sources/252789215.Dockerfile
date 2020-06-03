FROM ubuntu:14.04  
EXPOSE 8080  
RUN DEBIAN_FRONTEND=noninteractive \  
apt-get update && apt-get dist-upgrade -y  
  
RUN apt-get install -y \  
libmysqlclient-dev \  
mysql-client \  
python \  
python-dev \  
python-pip  
  
RUN pip install \  
ipython \  
mechanize \  
MySQL-python \  
stompy  
  
RUN useradd -m -s /bin/bash roundup  
  
RUN mkdir /start  
  
COPY start.sh /start/start.sh  
COPY init_tracker /start/init_tracker  
RUN chmod a+r /start/init_tracker  
  
RUN rm -f /tmp/*.log  
  
CMD /start/start.sh

