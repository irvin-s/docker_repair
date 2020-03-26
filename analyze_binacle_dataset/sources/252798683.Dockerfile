FROM nginx  
RUN mkdir /html  
WORKDIR /html  
COPY nginx.conf /etc/nginx/nginx.conf  
COPY ./html /html  

