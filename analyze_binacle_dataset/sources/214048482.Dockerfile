FROM busybox
MAINTAINER Dennis Micky Jensen <dj@miinto.com>

# Create default ghost content dirs
RUN mkdir -p /var/www/ghost/content/apps
RUN mkdir -p /var/www/ghost/content/images
RUN mkdir -p /var/www/ghost/content/themes
RUN mkdir -p /var/www/ghost/content/data