FROM elasticsearch:2.3.4

COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

RUN yes | ./bin/plugin install cloud-aws
RUN yes | ./bin/plugin install lmenezes/elasticsearch-kopf/2.0
RUN apt-get update && apt-get install -y nginx

COPY nginx.conf /etc/nginx/
RUN mkdir /ssl/
COPY cert-gen.sh /ssl/
WORKDIR /ssl
RUN /ssl/cert-gen.sh localhost logging
COPY elasticsearch.yml /usr/share/elasticsearch/config/
