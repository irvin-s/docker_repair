FROM gliderlabs/alpine
MAINTAINER kost - https://github.com/kost

RUN apk --update add openssl mysql-client postgresql-client postgresql-dev mysql-dev nginx make gcc libc-dev python python-dev py-pip git supervisor libxml2-dev libxslt-dev && \
    rm -f /var/cache/apk/* && \
    mkdir /app && \
    cd /app && \
    git clone https://github.com/certsocietegenerale/FIR.git fir && \
    cd fir && \
    pip install -r requirements.txt && \
    pip install gunicorn && \
    pip install psycopg2 && \
    pip install mysql-python && \
    cp -a /app/fir/fir/wsgi.py /app/fir/wsgi.py && \
    cp -a /app/fir/fir/urls.py.sample /app/fir/fir/urls.py && \
    cp -a /app/fir/fir/config/production.py.sample /app/fir/fir/config/production.py && \
    adduser -D -s /bin/sh app app && \
    chown -R app.app /app && \
    mkdir /data && \
    chown -R app.app /data && \
    wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/1.4/gosu-amd64" && \
    chmod +x /usr/local/bin/gosu && \
    echo "Success"

ADD scripts /scripts
ADD config/nginx /etc/nginx
ADD config/supervisor.d /etc/supervisor.d

RUN mkdir /scripts/pre-exec.d && \
mkdir /scripts/pre-init.d && \
mkdir /scripts/pre-initdb.d && \
mkdir /scripts/post-initdb.d && \
chmod -R 755 /scripts

EXPOSE 80

ENTRYPOINT ["/scripts/run.sh"]
# ENTRYPOINT ["/bin/sh"]

