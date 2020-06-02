FROM perl:5.28.0
RUN cpanm -q App::cpm

WORKDIR /app
COPY . /app
RUN cpm install -g
