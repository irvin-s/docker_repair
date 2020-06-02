FROM ubuntu:14.04  
MAINTAINER Chris Walsh <chris24walsh@gmail.com>  
RUN apt-get update  
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -q python-all python-pip  
ADD ./requirements.txt /tmp/requirements.txt  
RUN pip install -qr /tmp/requirements.txt  
ADD ./ /opt/webapp/  
WORKDIR /opt/webapp  
EXPOSE 5000  
RUN chmod +x default.sh  
RUN chmod +x set_db_URI.sh  
CMD /bin/sh default.sh  

