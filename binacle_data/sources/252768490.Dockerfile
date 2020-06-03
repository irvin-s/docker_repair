FROM debian:jessie  
MAINTAINER B2B.Web.ID Data Analytics Platform Labs  
COPY sources.list /etc/apt/  
RUN apt-get update && \  
apt-get install -y r-base && \  
apt-get clean  
CMD ["/bin/bash"]  

