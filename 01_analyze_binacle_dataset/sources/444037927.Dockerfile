FROM xeor/base:7.2-1

MAINTAINER Lars Solberg <lars.solberg@gmail.com>
ENV REFRESHED_AT 2016-01-01

RUN yum upgrade -y && yum install -y nginx git && yum clean all && \
    git clone https://github.com/letsencrypt/letsencrypt /letsencrypt && cd /letsencrypt && ./letsencrypt-auto || true

COPY hooks/ /hooks/
COPY supervisord.d/ /etc/supervisord.d/
COPY nginx.tmpl /
COPY nginx.conf /etc/nginx/nginx.conf
COPY generator.sh /

EXPOSE 80
EXPOSE 443
