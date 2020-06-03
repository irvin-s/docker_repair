FROM library/nginx  
ADD cloudfleet.conf /etc/nginx/conf.d/default.conf  
ADD nginx.conf /etc/nginx/nginx.conf  
ADD mime.types /etc/nginx/mime.types  
ADD better-crypto.conf /etc/nginx/better-crypto.conf  
ADD start.sh /root/start.sh  
RUN (apt-get update && apt-get install dnsmasq -y)  
ADD dnsmasq.conf /etc/dnsmasq.conf  
  
CMD /root/start.sh  

