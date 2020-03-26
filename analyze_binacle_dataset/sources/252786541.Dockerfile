FROM devries/dnsmasq  
COPY ./dnsmasq.conf /etc/dnsmasq.conf  
COPY hosts /etc/althosts  
EXPOSE 53

