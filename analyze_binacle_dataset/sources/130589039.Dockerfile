FROM python:3.6-alpine3.7 AS development
WORKDIR /app

# Node
RUN apk add -U nodejs
COPY package.json /app
RUN npm install -g grunt-cli clientjade jshint
RUN npm install

# Python
RUN apk add -U postgresql-libs git libmagic libjpeg-turbo bash pcre \
    libxml2 libxslt xmlsec
RUN pip install --upgrade pip pip-tools

COPY requirements.in requirements.txt ./

# Install a virtual package with build dependencies voor pip install
# run pip install and remove build dependencies.
RUN apk add -U --virtual build-deps \
    python3-dev build-base linux-headers pcre-dev musl-dev \
    postgresql-dev libffi-dev libjpeg-turbo-dev libressl-dev zlib-dev \
    libxml2-dev libxslt-dev xmlsec-dev && \
    pip-sync && \
    pip install uwsgi && \
    pip install -r requirements.txt && \
    pip install -r requirements.txt && \
    apk del build-deps


FROM development AS production

# Copy the source into the image for production
COPY src/ /app/src
RUN mkdir -p /app/src/js/global && \
    clientjade src/jade/ > src/js/global/jade.js

COPY . /app
RUN grunt clean && grunt prod
RUN pybabel compile -d app/translations
RUN npm run build
