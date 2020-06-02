FROM nginx

VOLUME ["/etc/nginx/conf.d"]

COPY nginx.conf /etc/nginx/nginx.conf
COPY ./docker-entrypoint.sh /
COPY ./main /

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["nginx-daemon"]
