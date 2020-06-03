FROM node:0.12.4  
  
RUN npm install -g polld  
  
RUN mkdir -p /home/polld  
  
ADD ssh_config /root/.ssh/config  
ADD run.sh /home/polld/run.sh  
  
CMD /home/polld/run.sh  
  
  

