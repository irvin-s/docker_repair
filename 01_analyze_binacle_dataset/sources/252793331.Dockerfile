FROM node:8.1.2  
RUN apt-get update && apt-get --assume-yes install ocaml libelf-dev  
RUN npm install yarn@0.27.5 -g  
  
CMD [ "node" ]  

