FROM nginx:alpine

COPY nginx.conf /etc/nginx/
RUN mkdir -p /usr/template
RUN mkdir -p /usr/nginx/cache
COPY template /usr/template
EXPOSE 80
