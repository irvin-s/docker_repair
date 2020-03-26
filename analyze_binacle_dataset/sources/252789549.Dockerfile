FROM duraark/microservice-base  
  
MAINTAINER Martin Hecher <martin.hecher@fraunhofer.at>  
  
COPY ./ /opt/workbench-ui  
WORKDIR /opt/workbench-ui  
  
RUN npm install ember-cli -g && npm install  
RUN mv .git .git-tmp && bower install --allow-root; mv .git-tmp .git  
  
EXPOSE 4200  
CMD ["ember", "serve"]  

