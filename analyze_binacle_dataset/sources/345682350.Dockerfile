FROM nginx:1.9

ADD https://github.com/jwilder/dockerize/releases/download/v0.0.2/dockerize-linux-amd64-v0.0.2.tar.gz /dockerize.tgz
RUN tar -C /usr/local/bin/ -zxvf /dockerize.tgz \
    && chmod +x /usr/local/bin/dockerize \
    && rm /dockerize.tgz

COPY run.sh /
COPY default.conf.tmpl /app/default.conf.tmpl

ENV REDIRECT **None**

CMD ["/run.sh"]
