FROM ubuntu:trusty  
MAINTAINER Chris Hardekopf <cjh@ygdrasill.com>  
  
# Install packages required  
RUN apt-get update && \  
DEBIAN_FRONTEND=noninteractive apt-get install -y \  
python3 python3-pip libssl-dev libacl1-dev \  
openssh-client pkg-config libfuse-dev \  
sshfs && \  
rm -rf /var/lib/apt/lists/*  
  
# Install the python requirements  
ADD requirements.txt /opt/  
RUN pip3 install --upgrade --requirement /opt/requirements.txt  
  
# Install attic  
RUN pip3 install attic  
  
# Add the start script  
ADD start /opt/  
  
# Set the ENTRYPOINT  
ENTRYPOINT [ "/opt/start" ]  
##CMD [ "/opt/start" ]  

