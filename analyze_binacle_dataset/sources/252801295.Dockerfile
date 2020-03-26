FROM node  
MAINTAINER DynamicTeapots  
RUN mkdir /bitbargain  
ADD . /bitbargain  
WORKDIR /bitbargain  
RUN npm install  
RUN npm install -g nodemon  
LABEL Description="File server for bitBargain" Version="0.1"  
  
EXPOSE 80:80  
CMD ["npm", "start"]

