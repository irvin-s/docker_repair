FROM madnificent/ember:2.14.0 as ember  
  
MAINTAINER Esteban Sastre <esteban.sastre@tenforce.com>  
MAINTAINER Aad Versteden <madnificent@gmail.com>  
  
COPY . /app  
COPY user-interfaces /user-interfaces  
RUN npm install && bower install  
RUN npm rebuild node-sass  
RUN ember build  
  
FROM nginx:1  
RUN ln -s /usr/share/nginx/html /app && \  
ln -s /app/config/user-interfaces /app/user-interfaces  
COPY \--from=ember /app/dist /app  
COPY \--from=ember /user-interfaces /app/config/user-interfaces  

