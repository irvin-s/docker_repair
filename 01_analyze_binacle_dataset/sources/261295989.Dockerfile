FROM fluent/fluentd:v0.14-onbuild

RUN apk add --update --virtual .build-deps \
        sudo build-base ruby-dev \
    && sudo gem install \
            fluent-plugin-gelf-hs \
    && sudo gem sources --clear-all \
    && apk del .build-deps \
    && rm -rf /var/cache/apk/* \
            /home/fluent/.gem/ruby/2.3.0/cache/*.gem

ENV GELF_PORT=12201 \
    GELF_PROTOCOL=udp