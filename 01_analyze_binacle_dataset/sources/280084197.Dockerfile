FROM python:3.6-alpine
RUN mkdir /app
RUN apk --no-cache add \
  ffmpeg \
  git \
  imagemagick \
  unzip \
  zip
RUN apk --no-cache --virtual .build-deps add \
  bash \
  gcc \
  g++ \
  make \
  openssl\
  && mkdir /rdkafka \
  && cd /rdkafka \
  && wget https://github.com/edenhill/librdkafka/archive/v0.9.2.tar.gz \
  && tar xvzf v0.9.2.tar.gz \
  && cd librdkafka-0.9.2 \
  && ./configure --prefix=/usr \
  && make -j4 \
  && make install \
  && ldconfig /usr/local/lib \
  && apk del .build-deps \
  && rm -rf /rdkafka
COPY ./requirements.txt /app/
WORKDIR /app
RUN apk --no-cache --virtual .build-deps add \
  gcc \
  g++ \
  musl-dev \
  && pip install -r requirements.txt \
  && apk del .build-deps
COPY ["CHANGES.txt", \
  "README.md", \
  "setup.py", \
  "/app/"]
COPY *.ini /app/
RUN python setup.py develop
COPY . /app
CMD pserve
