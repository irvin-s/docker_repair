FROM bigwig/docker-test:testBase  
  
COPY conf/nginx.conf /etc/nginx/nginx.conf  
EXPOSE 80  
COPY app /app  
  
CMD ["nginx", "-g", "daemon off;"]  

