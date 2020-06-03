########################################
#	    Dockerfile for Facegame        #
########################################

FROM ubuntu:16.04

ENV DEBIAN_FRONTEND noninteractive
WORKDIR /opt/app/

RUN apt-get update && apt-get install -y \
    git \
    libxml2-dev \
    python \
    build-essential \
    make \
    gcc \
    python-dev \
    locales \
    python-pip \
    npm \
    curl \
    software-properties-common \
    libfreetype6 \
    libfontconfig \
    nginx-full \
    libpq-dev \
    libpcre3 libpcre3-dev libssl-dev \
    supervisor

COPY requirements.txt /opt/app/requirements.txt
RUN pip install -r requirements.txt

ENV DJANGO_SETTINGS_MODULE facegame.settings.settings
ENV REMOTE_USER topa
ENV SECRET_KEY default_insecure_secret

COPY . /opt/app/
COPY docker/facegame_nginx.conf /etc/nginx/sites-available/facegame_nginx.conf
COPY docker/start.sh /opt/app/start.sh
RUN ln -s /etc/nginx/sites-available/facegame_nginx.conf /etc/nginx/sites-enabled/
COPY docker/supervisord.conf /etc/supervisor/supervisord.conf
RUN echo "daemon off;\n" >> /etc/nginx/nginx.conf

EXPOSE 8000

RUN mkdir -p /opt/static

RUN ./manage.py collectstatic --noinput
RUN assetgen --profile dev assetgen.yaml

CMD ["bash", "start.sh"]
