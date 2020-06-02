FROM mhart/alpine-node:6  
WORKDIR /src  
ADD . .  
  
# If you need npm, don't use a base tag  
RUN npm install  
  
EXPOSE 8080  
CMD ["npm", "start"]

