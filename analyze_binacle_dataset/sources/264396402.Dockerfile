FROM nginx:1.13

COPY ./back/default.template /etc/nginx/conf.d/back.template
COPY ./front/default.template /etc/nginx/conf.d/front.template
COPY ./nginx.conf /etc/nginx/nginx.conf
RUN rm /etc/nginx/conf.d/default.conf

ENV DOLLAR $

CMD ["nginx", "-g", "daemon off;"]
