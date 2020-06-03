FROM nginx:1.15

COPY nginx.dev.conf /etc/nginx/nginx.conf

CMD ["nginx", "-g", "daemon off;"]
