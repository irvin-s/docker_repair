FROM deepcase/tftp-rancheros:0.7.1  
RUN apk add --no-cache nodejs bash  
COPY cloud-config/package.json /root/cloud-config/package.json  
WORKDIR /root/cloud-config  
RUN npm install  
COPY cloud-config/server.js /root/cloud-config/server.js  
COPY cloud-config/views/ /root/cloud-config/views/  
COPY cloud-config/config/ /root/cloud-config/config/  
COPY tftp.sh /root/tftp.sh  
VOLUME /root/cloud-config/config  
VOLUME /root/cloud-config/views  
EXPOSE 80  
CMD ["/root/tftp.sh"]  

