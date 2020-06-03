FROM dockerfile/nginx  
  
COPY nginx.conf /etc/nginx/sites-enabled/mastermind  
  
COPY . /mastermind  
RUN rm /mastermind/Dockerfile /mastermind/nginx.conf  

