FROM mhart/alpine-node:6.9.1  
MAINTAINER dimkk  
  
# add files to container  
ADD . /app  
  
# specify the working directory  
WORKDIR app  
  
RUN npm install -g typings gulp \  
&& npm install \  
&& typings install \  
&& gulp build  
  
# run application  
CMD ["npm", "start"]

