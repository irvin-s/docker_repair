From nginx

RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf
ADD default.conf /etc/nginx/conf.d/default.conf
ADD blockips.conf /etc/nginx/conf.d/blockips.conf

CMD ["nginx","-c","/etc/nginx/nginx.conf"]
