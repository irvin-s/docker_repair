FROM nginx:1.9.1
MAINTAINER Michael Hausenblas "michael.hausenblas@gmail.com"
ENV REFRESHED_AT 2015-06-19

COPY content /usr/share/nginx/html