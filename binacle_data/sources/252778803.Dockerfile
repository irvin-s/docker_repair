FROM node:6.10  
RUN npm install -g ungit  
WORKDIR /workspace  
VOLUME /workspace  
EXPOSE 8448  
CMD ["ungit"]  

