FROM node  
  
WORKDIR /mysite  
  
#RUN apt-get update && apt-get install -y nodejs npm  
COPY bin bin  
COPY node_modules node_modules  
COPY public public  
COPY routes routes  
COPY views views  
COPY app.js app.js  
COPY favicon.png favicon.png  
COPY index.html index.html  
COPY package.json package.json  
  
EXPOSE 3000  
RUN ls -l  
  
RUN node --version  
  
CMD ["npm", "start"]  

