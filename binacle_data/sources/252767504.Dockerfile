FROM node:8.9  
LABEL maintainer="Masahiro Yamauchi <sgt.yamauchi@gmail.com>"  
ENV work /work  
RUN mkdir $work  
WORKDIR ${work}  
COPY index.js $work  
COPY package.json $work  
RUN npm install  
EXPOSE 5000  
CMD ["npm", "start"]  

