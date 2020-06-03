FROM node:latest  
MAINTAINER Fahmi Akbar Wildana <fahmi.akbar.w@mail.ugm.ac.id>  
  
WORKDIR /cimenx  
  
RUN npm install -g pm2  
  
# DDOS  
RUN npm install -g ddos-stress && \  
git clone https://github.com/mlazarov/ddos-stress.git ddos  
  
VOLUME /cimenx/ddos/etc  
  
EXPOSE 3000 5004  
ENTRYPOINT pm2 start  
CMD ddos-stress/node.js -i 10  

