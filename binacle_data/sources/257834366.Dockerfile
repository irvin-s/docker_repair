FROM nginx

# Copy configuration files to the container
COPY default.conf /etc/nginx/conf.d/default.conf
