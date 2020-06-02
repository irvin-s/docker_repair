FROM ubuntu:latest
MAINTAINER bogdan@insomnihack.ch

ENV DEBIAN_FRONTEND noninteractive

COPY setup.sh /opt/
RUN bash /opt/setup.sh

COPY redis.conf /etc/redis/redis.conf
COPY mongod.conf /etc/mongod.conf
COPY nginx.conf /etc/nginx/sites-available/default

RUN mkdir -p /opt/kill_list \
    && mkdir -p /opt/kill_list/data

COPY entrypoint.sh /opt/kill_list/
COPY create_admin.js /opt/kill_list/
COPY kill_list/ssl/cert.pem /etc/ssl/
COPY kill_list/ssl/key.pem /etc/ssl/
COPY kill_list/ /opt/kill_list/

WORKDIR /opt/kill_list
RUN npm install \
    && npm install bcrypt \
    && rm -rf /opt/kill_list/ssl

EXPOSE 80 443

ENTRYPOINT ["./entrypoint.sh"]
CMD ["start_process"]

