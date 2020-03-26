FROM nginx:alpine
ENV appDir /var/www/public
COPY nginx.conf /etc/nginx/nginx.conf
RUN mkdir -p  /var/www/public
WORKDIR ${appDir}
# Add application files
ADD ./public/ /var/www/public/
EXPOSE 80