FROM nginx:1.15.2-alpine

EXPOSE 80

COPY [ "./docker/nginx.conf", "/etc/nginx/" ]

CMD ["nginx", "-g", "daemon off;"]
