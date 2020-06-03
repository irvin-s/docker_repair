FROM dahlb/alpine-node:latest  
  
ADD public public  
ADD src src  
COPY package.json package.json  
  
RUN npm install --prod  
  
ENV HTTP_PORT=80  
ENV UDP_PORT=33333  
ENV RETHINKDB_URL=tcp://rethinkdb:28015  
CMD ["npm", "start"]  

