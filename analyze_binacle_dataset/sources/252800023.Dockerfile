FROM node  
COPY dist /ccc/dist  
WORKDIR /ccc  
  
RUN npm install http-server -g  
EXPOSE 8080  
CMD ["http-server", "dist"]  
  

