FROM python:3.6-slim
ENV DJANGO_VERSION 1.11.4
ENV UNIT_VERSION 0.1

RUN apt-get update && apt-get install -y \
                gcc \
                gettext \
                mysql-client libmysqlclient-dev \
                sqlite3 build-essential wget curl \
        --no-install-recommends && rm -rf /var/lib/apt/lists/* \
&& cd /tmp && wget  -O - "http://unit.nginx.org/download/unit-$UNIT_VERSION.tar.gz" | tar  xvz   \
&& cd unit-$UNIT_VERSION \
&& ./configure --prefix=/usr  --modules=lib --control='*:8000' --log=/dev/stdout --pid=/var/run/unitd.pid \
&& ./configure python --module=py36\
&& make install \
&& pip install mysqlclient  django=="$DJANGO_VERSION" \
&& rm -rf /tmp/unit-$UNIT_VERSION \
&& apt-get remove --auto-remove -y  build-essential wget 

ADD  app.tar.gz /srv

# && cd /srv && django-admin startproject app

WORKDIR /srv/app

EXPOSE 8000 8080

CMD ["/usr/sbin/unitd", "--no-daemon"]
