FROM node:latest  
  
RUN mkdir -p /opt  
RUN cd /opt && git clone https://github.com/feross/bittorrent-tracker  
RUN cd /opt && git clone -b simple https://github.com/agustim/ginstant  
  
RUN cd /opt/bittorrent-tracker && npm install  
RUN cd /opt/ginstant && npm install  
  
ADD ./start.sh /start.sh  
  
EXPOSE 9100  
EXPOSE 8000  
CMD ["/bin/bash", "/start.sh"]  

