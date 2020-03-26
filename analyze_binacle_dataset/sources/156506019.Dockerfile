FROM nginx:latest

# Install Nano
RUN apt-get update && apt-get install -y nano

# Edit default index
COPY default_index.html /usr/share/nginx/html/index.html

# Add symfony nginx config
COPY symfony.conf /etc/nginx/conf.d/symfony.conf