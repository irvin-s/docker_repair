# Base node  
FROM node:latest  
RUN cd /home; npm install sc5-styleguide --save-dev  
RUN cd /home; npm install gulp --save-dev  
RUN cd /home; npm install gulp-sass --save-dev  
RUN npm -g install gulp --save-dev  
  
COPY styleguide_endpoint.sh /  
CMD sh styleguide_endpoint.sh  

