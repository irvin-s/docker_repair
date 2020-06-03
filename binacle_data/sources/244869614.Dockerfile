# Get the NGINX Image from https://hub.docker.com/
FROM nginx:1.11.10

LABEL version="1.0"
LABEL description="NGINX version 1.11.10"
LABEL author="PreciousDev"
LABEL authorURL="https://github.com/preciousDev"

# Remove the default NGINX configurations
RUN rm -v /etc/nginx/nginx.conf

# Add our custom configuration file to replace the original one
ADD nginx.conf /etc/nginx/

RUN echo "daemon off;" >> /etc/nginx/nginx.conf

# "The EXPOSE instruction informs Docker that the container listens on the specified network ports at runtime"
# https://docs.docker.com/engine/reference/builder/#expose
EXPOSE 80 443

# Start NGINX
CMD service nginx start