FROM nginx:latest

MAINTAINER Ahmad Shah Hafizan Hamidin <ahmadshahhafizan@gmail.com>

ADD nginx.conf /etc/nginx/nginx.conf
ADD lego.conf /etc/nginx/sites-available/default.conf

CMD ["nginx"]

EXPOSE 80 443