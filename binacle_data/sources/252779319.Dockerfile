FROM node  
  
RUN npm -g install bower brunch coffee-script  
WORKDIR /app  
  
ENTRYPOINT ["npm"]  
CMD ["run", "start-production"]  

