# run as:  
# docker build -f Dockerfile -t gradienttool .  
# base everything on a recent Ubuntu  
FROM debian:latest  
  
# get system packages up to date then install a basic python  
RUN apt-get update && apt-get -y upgrade && \  
apt-get -y install python3 ttf-bitstream-vera  
  
# set up code  
RUN mkdir /scripts  
COPY scripts/ /scripts/  
ENTRYPOINT ["python3", "/scripts/gradienttool_filter.py"]

