FROM alpine:3.5  
RUN apk add --no-cache git make bind-tools openssh && \  
mkdir /root/.ssh && \  
mkdir -p /etc/tinydns/env && \  
mkdir /etc/tinydns/root && \  
echo "/etc/tinydns/root" > /etc/tinydns/env/ROOT && \  
echo "0.0.0.0" > /etc/tinydns/env/IP && \  
echo "tinydns" > /etc/tinydns/env/UID && \  
echo "tinydns" > /etc/tinydns/env/GID  
  
COPY ./bin/tinydns /usr/local/bin/  
COPY ./bin/tinydns-data /usr/local/bin/  
COPY ./bin/tai64n /usr/local/bin/  
COPY ./bin/tai64nlocal /usr/local/bin/  
COPY ./bin/dnsdata_update.sh /  
COPY ./bin/run_tinydns.sh /  
  
EXPOSE 53/udp  
  
CMD ["/run_tinydns.sh"]  

