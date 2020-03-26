FROM ubuntu:16.04  
# Switches deb source to China mirror  
RUN sed -i.bak 's/archive/cn\\.archive/' /etc/apt/sources.list  
  
# Deploys files  
RUN mkdir -p /app  
RUN mkdir -p /app/kcp  
RUN mkdir -p /app/proxycfg  
RUN chmod +x /app  
COPY ./client_linux_amd64 /app/kcp  
COPY ./server_linux_amd64 /app/kcp  
RUN chmod +x /app/kcp/client_linux_amd64  
RUN chmod +x /app/kcp/server_linux_amd64  
  
COPY ./dtunnel_lite /usr/bin/  
RUN chmod +x /usr/bin/dtunnel_lite  
  
ADD ./packages/xware.tar.gz /app/  
#ADD ./packages/kcp.tar.gz /app/  
ADD ./packages/3proxy.tar.gz /app/  
COPY ./packages/*.deb /app/  
COPY ./*.sh /app/  
RUN chmod +x /app/*.sh  
  
RUN dpkg -i /app/libmbedcrypto0_*.deb  
RUN dpkg -i /app/shadowsocks-libev_*.deb  
RUN rm /etc/init.d/shadowsocks-libev  
  
RUN dpkg -i /app/libpopt0_*.deb  
RUN dpkg -i /app/cron_*.deb  
RUN dpkg -i /app/logrotate_*.deb  
RUN dpkg -i /app/privoxy_*.deb  
RUN rm /etc/init.d/privoxy  
  
RUN dpkg -i /app/libc6_*.deb  
RUN dpkg -i /app/libc6-i386_*.deb  
RUN dpkg -i /app/lib32z1_*.deb  
  
RUN rm -rf /app/*.deb  
  
WORKDIR /app  

