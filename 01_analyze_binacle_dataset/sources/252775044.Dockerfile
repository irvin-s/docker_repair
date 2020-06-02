FROM madnificent/ember:2.14.0 as ember  
MAINTAINER Esteban Sastre <esteban.sastre@tenforce.com>  
  
COPY . /app  
RUN npm install && bower install  
RUN npm rebuild node-sass  
RUN ember build  
  
FROM semtech/mu-nginx-spa-proxy  
COPY \--from=ember /app/dist /app  

