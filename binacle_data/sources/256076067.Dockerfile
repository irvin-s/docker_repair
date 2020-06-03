FROM nginx:latest
ADD nginx.conf /etc/nginx/nginx.conf
RUN echo '<html><body><p>This application is <strong style="color: blue;">BLUE</strong>.</body></html>' > /usr/share/nginx/html/index.html
RUN echo 'OK' > /usr/share/nginx/html/healthy.html