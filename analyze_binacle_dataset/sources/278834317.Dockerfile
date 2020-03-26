# Stage 1 - Compile needed python dependencies
FROM alpine:3.7 AS build
RUN apk --no-cache add \
    gcc \
    musl-dev \
    pcre-dev \
    linux-headers \
    postgresql-dev \
    python3 \
    python3-dev \
    # lxml
    libxslt-dev \
    # Pillow dependencies
    jpeg-dev \
    openjpeg-dev \
    zlib-dev \
    # Remote deps
    git
RUN pip3 install virtualenv
RUN virtualenv /app/env

WORKDIR /app

COPY ./requirements /app/requirements
RUN /app/env/bin/python -m pip install --upgrade pip
RUN /app/env/bin/pip install -r requirements/dev.txt
RUN /app/env/bin/pip install uwsgi

# Stage 2 - Build docker image suitable for execution and deployment
FROM alpine:3.7
RUN apk --no-cache add \
      ca-certificates \
      mailcap \
      musl \
      pcre \
      postgresql \
      python3 \
      zlib \
      libxslt

COPY ./src /app/src
COPY ./zds /app/zds
COPY ./docker/start.sh /start.sh
RUN mkdir /app/log

COPY --from=build /app/env /app/env

ENV PATH="/app/env/bin:${PATH}"
WORKDIR /app
EXPOSE 8000
CMD ["/start.sh"]