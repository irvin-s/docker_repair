FROM node:latest  
  
LABEL authors="Justin <digitaldrummerj@gmail.com>"  
  
RUN npm i -g grunt-cli sails;npm cache clear  
  
EXPOSE 1337  
ENV HOME=/home/app  
WORKDIR $HOME  
  
# ONBUILD WORKDIR $HOME  
# ONBUILD RUN npm install  
# ONBUILD ENTRYPOINT ["/bin/sh", "-c"]  
# ONBUILD CMD ["sails lift"]  

