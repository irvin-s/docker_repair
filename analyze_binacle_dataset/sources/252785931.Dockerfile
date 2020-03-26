FROM djmattyg007/arch-runit-base:2017.02.13-1  
MAINTAINER djmattyg007  
  
ENV TIMESCHEDIMAGE_VERSION=2017.02.13-1  
# Add install bash script  
COPY setup/root/*.sh /root/  
# Add runit init script  
COPY setup/init.sh /etc/service/nginx/run  
# Add nginx server block files and templates  
COPY setup/*.ngx /etc/timesched/nginx/  
# Add main nginx config file  
COPY setup/nginx.custom.conf /etc/nginx/  
  
ENV TIMESCHED_VERSION=1  
# Run bash script to install nginx and download the timesched code  
RUN /root/install.sh && \  
rm /root/*.sh  
  
ENTRYPOINT ["/usr/bin/init"]  

