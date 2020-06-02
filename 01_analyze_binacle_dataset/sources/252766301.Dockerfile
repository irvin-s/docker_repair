# Version 1.2  
FROM abh1nav/python  
  
MAINTAINER Abhinav Ajgaonkar <abhinav316@gmail.com>  
  
# Download and extract OpsCenter  
RUN \  
mkdir /opt/opscenter; \  
wget -O - http://downloads.datastax.com/community/opscenter-5.1.0.tar.gz \  
| tar xzf - --strip-components=1 -C "/opt/opscenter";  
  
ADD . /src  
  
# Copy over daemons  
RUN \  
mkdir -p /etc/service/opscenter; \  
cp /src/run /etc/service/opscenter/; \  
ln -s /opt/opscenter/log /var/log/opscenter;  
  
# Expose ports  
EXPOSE 8888  
WORKDIR /opt/opscenter  
  
CMD ["/sbin/my_init"]  
  
# Clean up  
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  

