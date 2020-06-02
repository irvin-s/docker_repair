FROM python:3.4-slim

ENV WORKON_HOME=~/envs

# May not need this - but I had some issues with a Debian mirror not responding
# and added another as a fallback
RUN echo "deb http://ftp.uk.debian.org/debian jessie main" >> /etc/apt/sources.list

RUN apt-get update && apt-get install -y \
        gcc \
        gettext \
        postgresql-client \
        libpq-dev \
        netcat \
    --no-install-recommends && rm -rf /var/lib/apt/lists/* \
    && pip install virtualenvwrapper \
    && mkdir -p $WORKON_HOME \
    && mkdir -p /var/www/app \
    && echo "source /usr/local/bin/virtualenvwrapper.sh" >> ~/.bashrc

EXPOSE 8000

WORKDIR /var/www/app

COPY requirements.txt /var/www/app

RUN /bin/bash --login -c "mkvirtualenv -a /var/www/app -r requirements.txt app" \
    && echo "workon app" >> ~/.bashrc

COPY . /var/www/app

CMD []