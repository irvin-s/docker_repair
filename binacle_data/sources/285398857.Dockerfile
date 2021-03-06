FROM node:alpine

LABEL maintainer="arne@hilmann.de"

ARG pandoc_version
ARG version
ARG motto

RUN apk add --update \
    graphviz inotify-tools rsync \
    libqrencode jq sassc zip openjdk8-jre \
    python make g++ bash cairo curl fontconfig \
    py2-pip \
    && rm -rf /var/cache/apk/*

RUN npm -g config set user root
RUN npm install -g mathjax-pandoc-filter vega vega-lite && npm cache clean --force

RUN mkdir -p /usr/local/share/lua/5.3
RUN curl -o /usr/local/share/lua/5.3/inspect.lua -L https://raw.githubusercontent.com/kikito/inspect.lua/master/inspect.lua

RUN pip install MarkdownPP

COPY downloaded/ /usr
RUN mkdir -p /markdeck/
COPY markdeck/ /markdeck/
WORKDIR /markdeck
RUN ln -sf /target/assets/css/fonts /.fonts
RUN ln -sf /markdeck/assets/markdeck/css/fonts/ /usr/share/fonts

ENV VERSION $version
ENV MOTTO $motto
VOLUME ["/source", "/target"]

RUN chown :1999 /target
RUN chmod 755 /target
RUN chmod g+s /target
RUN addgroup -g 1999 markdeck
RUN adduser -D -H -G markdeck markdeck
USER markdeck

ENTRYPOINT ["/markdeck/loop"]
# ENTRYPOINT sleep 1d
