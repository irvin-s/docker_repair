FROM dottgonzo/docker-nginx-htmlsite  
MAINTAINER Dario Caruso <dev@dariocaruso.info>  
COPY ./dist /usr/share/nginx/html

