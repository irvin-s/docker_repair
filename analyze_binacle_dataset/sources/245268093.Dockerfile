# Set the base image to Ubuntu
FROM nginx:1.10
# File Author / Maintainer
MAINTAINER Ionut Lepadatescu
# Define working directory
ADD ./client /usr/share/nginx/html
RUN rm -f /etc/nginx/conf.d/default.conf
ADD ./configs/sites /etc/nginx/conf.d/
# Expose port
EXPOSE  80
LABEL ldir.web=static
