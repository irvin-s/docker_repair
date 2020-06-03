FROM node:0.11-slim  
RUN npm install -g rainbow-dns  
ENTRYPOINT ["rainbow-dns"]  

