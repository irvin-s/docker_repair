ARG TAG=1.15.12-alpine

FROM nginx:$TAG

LABEL mantainer="developer@fabriziocafolla.com"
LABEL description="Nginx Container"

# ARG EXP=80

# ADD data in image when build
ADD ./webserver/vhosts.conf /etc/nginx/conf.d/default.conf

# EXPOSE $EXP
