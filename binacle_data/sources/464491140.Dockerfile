## Base image with python and entrypoint scripts ##
## ============================================= ##
FROM python:3.6.8-alpine3.9 AS base

LABEL maintainer="Adam Hodges <ahodges@shipchain.io>"

ENV LANG C.UTF-8
ENV PYTHONUNBUFFERED 1

# Essential packages for our app environment
RUN apk add --no-cache bash curl binutils && \
    apk add --no-cache --repository http://dl-3.alpinelinux.org/alpine/edge/main/ libcrypto1.1 && \
    apk add --no-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ proj-dev gdal geos && \
    curl -sSL https://raw.githubusercontent.com/sdispater/poetry/master/get-poetry.py | python && \
    apk del curl
RUN ln -s /usr/lib/libgeos_c.so.1 /usr/local/lib/libgeos_c.so && ln -s /usr/lib/libgdal.so.20 /usr/lib/libgdal.so

# Install and configure virtualenv
RUN pip install virtualenv==16.3.*
ENV VIRTUAL_ENV=/app/.virtualenv
ENV PATH=$VIRTUAL_ENV/bin:/root/.poetry/bin:$PATH

# Initialize app dir and entrypoint scripts
RUN mkdir /app
WORKDIR /app
COPY ./compose/django/*.sh /
RUN chmod +x /*.sh
ENTRYPOINT ["/entrypoint.sh"]

## Image with system dependencies for building ##
## =========================================== ##
FROM base AS build

# Essential packages for building python packages
RUN apk add --no-cache build-base git libffi-dev linux-headers jpeg-dev libressl2.7-libssl freetype-dev postgresql-dev su-exec


## Image with additional dependencies for local docker usage ##
## ========================================================= ##
FROM build as local
RUN chmod -R 777 /root/  ## Grant all local users access to poetry


## Image with dev-dependencies ##
## =========================== ##
FROM build AS test

COPY . /app/
RUN \[ -d "$VIRTUAL_ENV" \] || virtualenv "$VIRTUAL_ENV"
RUN . "$VIRTUAL_ENV/bin/activate" && poetry install


## Image only used for production building ##
## ======================================= ##
FROM build AS prod

COPY . /app/
RUN \[ -d "$VIRTUAL_ENV" \] || virtualenv "$VIRTUAL_ENV"
RUN . "$VIRTUAL_ENV/bin/activate" && poetry install --no-dev

# Generate static assets
RUN python manage.py collectstatic -c --noinput


## Image to be deployed to ECS with additional utils and no build tools ##
## ==================================================================== ##
FROM base AS deploy

# Install openssh for ECS management container
RUN apk add --no-cache jq openssl openssh-server-pam shadow nano
RUN sed -i 's/^CREATE_MAIL_SPOOL=yes/CREATE_MAIL_SPOOL=no/' /etc/default/useradd

# Keymaker for SSH auth via IAM
RUN mkdir /var/run/sshd /etc/cron.d && touch /etc/pam.d/sshd
RUN pip install keymaker==1.0.8

# Configure public key SSH
RUN echo "PubkeyAuthentication yes" >> /etc/ssh/sshd_config
RUN echo "UsePAM yes" >> /etc/ssh/sshd_config
RUN echo "AllowAgentForwarding yes" >> /etc/ssh/sshd_config
RUN echo "PasswordAuthentication no" >> /etc/ssh/sshd_config

# Create virtualenv for using awscli in entrypoint scripts
RUN virtualenv /opt/aws
RUN . /opt/aws/bin/activate && pip install awscli==1.16.*

# Copy built virtualenv without having to install build-essentials, etc
COPY --from=prod /app /app
