
FROM nginx

COPY ./nginx.conf /etc/nginx/

CMD ["nginx", "-g", "daemon off;"]

