FROM node:6.9.5  
ENV PORT 8080  
EXPOSE ${PORT}  
  
ENV NPM_CONFIG_LOGLEVEL warn  
  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
  
COPY ./package.json .  
RUN npm install  
  
COPY ./test.js .  
COPY ./src ./src  
  
ENTRYPOINT ["npm"]  
CMD ["start"]  

