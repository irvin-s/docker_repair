FROM nginx:1.13.1

COPY ./sites-enabled/app.conf /etc/nginx/conf.d/
COPY nginx.conf /etc/nginx/

RUN rm -f /etc/nginx/conf.d/default.conf

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

CMD ["/entrypoint.sh"]
