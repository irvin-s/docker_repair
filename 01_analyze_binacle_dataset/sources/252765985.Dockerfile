FROM node  
  
WORKDIR /app  
  
# Fetch the dependancies  
COPY ./package.json /app/package.json  
RUN npm install  
  
# Copy in source, this wont copy node_modules because its in the .dockerignore  
COPY ./ /app  
  
CMD npm start  

