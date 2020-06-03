FROM python:2.7-slim
LABEL Description="This image is used to start a Factored instance" Vendor="Wildcard Corp." Version="1.0"

# the deps for ldap integration will be installed right away too
RUN apt-get -y update && apt-get -y install \
    libldap2-dev libsasl2-dev \
    libsqlite3-dev

COPY docker-entrypoint.sh /

RUN mkdir /app
WORKDIR /app

# we do this because requirements change less than other files, which means
# the next copy step for putting the rest of the source code into the container
# won't force pip installation every update
COPY requirements.txt /app
RUN pip install -r requirements.txt

COPY . /app
RUN python setup.py develop
