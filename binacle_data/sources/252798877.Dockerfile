# use a node base image  
FROM node:8-onbuild  
# set maintainer  
LABEL maintainer "devenrpanchal@gmail.com"  
  
# tell docker what port to expose  
EXPOSE 8081  

