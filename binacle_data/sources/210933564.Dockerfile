FROM alpine:3.6

ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk
ENV PATH $PATH:$JAVA_HOME/bin

RUN apk add --update --no-cache gcc g++ make openjdk8-jre ruby-dev ruby ruby-nokogiri ruby-json asciidoctor ttf-dejavu zlib zlib-dev && \
    gem install --no-ri --no-rdoc asciidoctor-diagram && \
    gem install --no-ri --no-rdoc asciidoctor-pdf --pre && \
    gem install --no-ri --no-rdoc asciidoctor-epub3 --pre && \
    gem install --no-ri --no-rdoc asciidoctor-confluence && \
    gem install --no-ri --no-rdoc coderay && \
    gem cleanup && \
    apk del gcc g++ make ruby-dev zlib-dev && \
    rm -rf /tmp/* /var/cache/apk/*

WORKDIR /documents
VOLUME /documents

CMD ["/bin/sh"]
