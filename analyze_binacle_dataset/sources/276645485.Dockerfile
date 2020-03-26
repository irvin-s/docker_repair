FROM nginx

COPY symfony.conf /etc/nginx/conf.d/default.conf

CMD ["nginx", "-g", "daemon off;"]