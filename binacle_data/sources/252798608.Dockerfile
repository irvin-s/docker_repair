# sudo docker build -t derekbekoe/marie-web:dev .  
# sudo docker run -d -p 80:80 derekbekoe/marie-web:dev  
# sudo docker run -d -p 5000:80 derekbekoe/marie-web:dev  
FROM kyma/docker-nginx  
COPY src/ /var/www  
CMD 'nginx'  

