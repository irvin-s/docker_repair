FROM nginx

LABEL maintainer="Adam Hodges <ahodges@shipchain.io>"

RUN apt-get update
RUN apt-get install -y python-pip jq
RUN pip install awscli

RUN mkdir -p /etc/nginx/certs
ADD ./nginx.conf /etc/nginx/conf.d/default.conf

COPY ./*.sh /
RUN chmod +x /*.sh
ENTRYPOINT ["/entrypoint.sh"]
