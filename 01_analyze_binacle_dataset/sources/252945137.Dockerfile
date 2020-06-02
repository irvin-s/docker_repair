FROM debian:latest
MAINTAINER MoD <mod@kaigara.org>

ENV HUGO_VERSION=0.25

RUN apt-get update -y \
      && apt-get install -y \
      wget git ca-certificates \
      && rm -rf /var/lib/apt/lists/*

RUN wget -q https://github.com/spf13/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz && \
      tar xzf hugo_${HUGO_VERSION}_Linux-64bit.tar.gz && \
      rm -r hugo_${HUGO_VERSION}_Linux-64bit.tar.gz && \
      mv hugo /usr/local/bin/hugo

RUN groupadd web
RUN useradd -g web -m web

ADD . /home/web
RUN chown web /home/web -R
USER web

WORKDIR /home/web

EXPOSE 8080

ENTRYPOINT ["hugo"]

CMD ["server", "--bind=0.0.0.0", "--port=8080", "--appendPort=false", "--baseURL=https://www.kaigara.org", "--watch=false"]
