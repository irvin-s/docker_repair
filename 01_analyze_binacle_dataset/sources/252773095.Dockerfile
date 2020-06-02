FROM node:8.10.0  
RUN apt-get update && apt-get install -y \  
vim  
  
COPY . /srv/  
  
RUN cd /srv && \  
rm package-lock.json || true && \  
rm -R node_modules || true && \  
npm i  
  
EXPOSE 443 80  
WORKDIR /srv  
  
CMD ["npm","start"]  

