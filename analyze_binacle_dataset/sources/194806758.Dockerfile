FROM php:7.1-fpm-jessie

RUN apt-get update \
    && apt-get install --no-install-recommends --no-install-suggests -y \
                        python-pip \
                        python-dev \
                        libffi-dev \
                        libssl-dev \
                        libxml2-dev \
                        libxslt1-dev \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade markupsafe setuptools
RUN pip install --upgrade ansible
RUN ansible --version
