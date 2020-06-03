# Dockerfile for Nginx -- Event Sourcing Microservices Example

FROM nginx:latest

MAINTAINER Amjad Afanah <amjad@dchq.io>

RUN mv /usr/share/nginx/html/index.html /usr/share/nginx/html/index.html.bak
RUN mv /usr/share/nginx/html/50x.html /usr/share/nginx/html/50x.html.bak

COPY ./software /usr/share/nginx/html/
