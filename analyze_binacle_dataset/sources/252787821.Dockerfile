FROM cperezvinsite/node-python:node6.9.3  
MAINTAINER Camilo Perez <cperezv@insite.com.co>  
  
COPY package.json /tmp/package.json  
  
RUN mkdir /app  
WORKDIR /tmp  
  
RUN npm install \  
&& mv /tmp/node_modules /app/ \  
&& npm cache clean --force  
ENV PORT=6000  
EXPOSE 6000  
# Set the working directory to /app  
WORKDIR /app  
  
# Copy the current directory contents into the container at /app  
COPY . /app  
  
CMD ["node","bin/www"]

