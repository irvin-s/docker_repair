FROM nginx

COPY index.prod.html /usr/share/nginx/html/index.html

CMD sh -c "nginx && sleep 1 && echo nginx online && tail -f /dev/null"
