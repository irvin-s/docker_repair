FROM nginx:1.9.4  
MAINTAINER Aleh Humbar og@gsl.tv  
  
COPY /nginx.conf /etc/nginx/nginx.conf  
COPY /static.conf /etc/nginx/static.conf  
COPY /api-mocks.conf /etc/nginx/api-mocks.conf  
  
EXPOSE 80 443  
CMD ["nginx", "-g", "daemon off;"]

