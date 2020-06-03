FROM ubuntu:18.04
LABEL maintainer="Basu Dubey <basu.96@gmail.com>"

ENV CRUXJUDGE_REPO_URL="https://github.com/crux-bphc/crux-judge.git" \
    CRUXJUDGE_REPO_REF="master"

# Install dependencies
RUN apt-get update && apt-get install --no-install-recommends -y \
    build-essential \
    git \
    sudo \
    libseccomp2 \
    libseccomp-dev \
    python3 \
    python3-dev \
    python3-pip \
    python3-setuptools \
    python3-wheel \
    nginx \
    nano \
    && rm -rf /var/lib/apt/lists/* \
    && pip3 install Django==1.11.2 uwsgi django-ipware

# Set up crux judge and nginx
RUN mkdir "/root/home" \ 
    && git clone $CRUXJUDGE_REPO_URL /root/home/cruxjudge \
    && cd /root/home/cruxjudge && git checkout $CRUXJUDGE_REPO_REF \
    && mkdir -p "/root/home/cruxjudge/src/server/contest/testcases" \
    && mkdir -p "/root/home/cruxjudge/src/server/contest/sandbox/jail" \
    && cp /root/home/cruxjudge/docker/cruxjudge_nginx.conf /etc/nginx/sites-available/ \
    && ln -s /etc/nginx/sites-available/cruxjudge_nginx.conf /etc/nginx/sites-enabled/cruxjudge_nginx.conf \
    && chown -R www-data /root

WORKDIR /root/home/cruxjudge/src/server

CMD python3 manage.py collectstatic \
    && python3 manage.py migrate \
    && gcc contest/sandbox/*.c -lm -pthread -lseccomp -o contest/sandbox/sandbox-exe \
    && service nginx restart \
    && uwsgi --ini /root/home/cruxjudge/docker/cruxjudge_uwsgi.ini

EXPOSE 8000
