FROM nginx:1.14-alpine  
COPY . /usr/share/nginx/html/  
COPY env/dev/*.png /usr/share/nginx/html/resources/img/  
RUN sed -i 's/${env}/dev/' /usr/share/nginx/html/index.html

