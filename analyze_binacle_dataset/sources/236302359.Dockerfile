FROM radanalyticsio/radanalytics-io-base

COPY . /srv/site

WORKDIR /srv/site

USER root

RUN bower --allow-root install && \
    bundler install && \
    chown -R 1001:1001 /srv

USER 1001

CMD bundler exec jekyll serve -H 0.0.0.0
