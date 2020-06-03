FROM node:6  
RUN apt-get update \  
&& apt-get install -y git  
  
RUN npm install --global grunt-cli \  
&& npm install --global foundation-cli \  
&& npm install --global browser-sync \  
&& npm install --global bower  
  
COPY package.json /source/  
  
RUN cd /source \  
&& npm install  
  
USER node  
  
WORKDIR /source  
  
EXPOSE 3000 3001  
CMD ["grunt"]  

