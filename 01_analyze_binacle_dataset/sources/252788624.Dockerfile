# node base image to use  
FROM node  
  
# official maintainer  
MAINTAINER Christian Haug  
  
# create src directory  
RUN mkdir -p /loadapp  
WORKDIR /loadapp  
  
# copy dependency files and install them  
COPY package.json /loadapp  
RUN npm install  
  
# copy master src code  
COPY . /loadapp  
  
# container port to expose  
EXPOSE 8000  
# default command to execute when starting master container  
CMD ["npm", "run", "prodstart"]

