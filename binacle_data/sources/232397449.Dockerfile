FROM nginx:stable

LABEL maintainer="Florian JUDITH <florian.judith.b@gmail.com>"

RUN rm -f /etc/nginx/conf.d/default.conf
RUN rm -f /etc/nginx/conf.d/example_ssl.conf

COPY jenkins.conf /etc/nginx/conf.d/jenkins.conf
COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80


CMD ["nginx"]