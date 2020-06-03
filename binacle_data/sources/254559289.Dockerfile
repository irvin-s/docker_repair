FROM nginx:alpine

RUN mkdir -p /home/nginx/logs

COPY nginx/nginx.conf /etc/nginx/nginx.conf
COPY nginx/app.conf /etc/nginx/conf.d/app.conf
COPY app/public /home/nginx/public

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /home/nginx/logs/access.log \
  && ln -sf /dev/stderr /home/nginx/logs/error.log

EXPOSE 80

CMD [ "nginx" ]
