FROM ubuntu
#FROM armv7/armhf-ubuntu
RUN apt-get update;apt-get install -y nginx

#ENV Variables
ENV TERM xterm

#Run in foreground
RUN sed -i '1s/^/daemon off; /' /etc/nginx/nginx.conf
EXPOSE 443 80

CMD nginx
