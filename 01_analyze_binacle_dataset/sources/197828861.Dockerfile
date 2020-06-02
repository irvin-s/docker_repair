FROM nginx:1.11.1

COPY nginx.conf /etc/nginx/nginx.conf
COPY build /usr/share/nginx/html

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]
