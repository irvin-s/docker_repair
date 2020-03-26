FROM nginx:1.9
COPY dist /usr/share/nginx/html
EXPOSE 80
CMD /bin/bash -c "nginx -g 'daemon off;'"
