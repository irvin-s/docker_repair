ARG NODE_VERSION=8  
FROM node:${NODE_VERSION}  
  
COPY . /home/node/app  
WORKDIR /home/node/app  
  
RUN yarn global add @chialab/rna-cli \  
&& rna install \  
&& rna build  
  
EXPOSE 3000  
HEALTHCHECK \--interval=30s --timeout=3s --start-period=1m \  
CMD curl -f http://localhost:3000/ || exit 1  
  
CMD ["npm", "start"]  

