FROM nginx  
  
RUN apt-get update && apt-get install nano  
# WORKDIR /usr/share/nginx/html  
COPY . ./usr/share/nginx/html  
  

