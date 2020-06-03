FROM python:3.5.1  
MAINTAINER André andris.jersovs@accenture.com  
  
ARG F2B_VERSION=0.10.0a1  
  
RUN apt-get update && \  
apt-get install -y wget unzip iptables && \  
wget https://github.com/fail2ban/fail2ban/archive/${F2B_VERSION}.zip && \  
unzip ${F2B_VERSION}.zip && \  
rm ${F2B_VERSION}.zip  
WORKDIR /fail2ban-${F2B_VERSION}  
RUN python setup.py install && \  
cp files/debian-initd /etc/init.d/fail2ban && \  
update-rc.d fail2ban defaults  
WORKDIR /  
ADD jail.local /etc/fail2ban/  
  
RUN rm -rf fail2ban-${F2B_VERSION} && \  
apt-get clean && \  
rm -rf /var/lib/apt/lists/*  
  
CMD fail2ban-client -x start && tailf /var/log/fail2ban.log  

