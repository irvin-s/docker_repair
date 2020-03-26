FROM resin/rpi-raspbian:jessie

ENV ERR_USER err
ENV DEBIAN_FRONTEND noninteractive
ENV PATH /app/venv/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

ENV LC_ALL C.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

RUN groupadd -r $ERR_USER && \
    useradd -r \
       -g $ERR_USER \
       -d /srv \
       $ERR_USER

RUN apt-get update && apt-get install -y -q \
         git \
         locales \
         dnsutils \
         python3-dnspython \
         python3-openssl \
         python3-pip \
         python3-cffi \
         python3-pyasn1 \
         --no-install-recommends && \
         rm -rf /var/lib/apt-lists/*

RUN locale-gen C.UTF-8 && \
    /usr/sbin/update-locale LANG=C.UTF-8 && \
    echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen && \
    locale-gen

RUN pip3 install virtualenv && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir /srv/data /srv/plugins /srv/errbackends /app && \
    chown -R $ERR_USER: /srv /app

USER $ERR_USER
WORKDIR /srv

COPY requirements.txt /app/requirements.txt

RUN virtualenv --system-site-packages -p python3 /app/venv
RUN /app/venv/bin/pip3 install --no-cache-dir -r /app/requirements.txt

COPY config.py /app/config.py
COPY run.sh /app/venv/bin/run.sh

EXPOSE 3141 3142
VOLUME ["/srv"]

CMD ["/app/venv/bin/run.sh"]
