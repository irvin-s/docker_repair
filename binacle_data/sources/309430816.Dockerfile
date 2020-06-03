FROM nginx:1.13.12
MAINTAINER justmine
WORKDIR /usr/share/nginx/html
ADD ["exceptionless.ui.tar.gz","."]


