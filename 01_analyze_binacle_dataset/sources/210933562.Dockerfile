FROM alpine:3.6

ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk
ENV PATH $PATH:$JAVA_HOME/bin
ENV LIBRARY_PATH=/lib:/usr/lib
ENV BACKENDS /asciidoctor-backends
ENV GVM_AUTO_ANSWER true

RUN apk add --update --no-cache gcc g++ make bash curl unzip tar openjdk8-jre ruby-dev ruby ruby-nokogiri ruby-json asciidoctor python python-dev py-setuptools py-pip ttf-dejavu graphviz libjpeg-turbo libjpeg-turbo-dev zlib zlib-dev zip && \
    gem install --no-ri --no-rdoc asciidoctor-diagram && \
    gem install --no-ri --no-rdoc asciidoctor-pdf --pre && \
    gem install --no-ri --no-rdoc asciidoctor-epub3 --pre && \
    gem install --no-ri --no-rdoc asciidoctor-confluence && \
    gem install --no-ri --no-rdoc asciidoctor-rouge && \
    gem install --no-ri --no-rdoc coderay pygments.rb thread_safe epubcheck kindlegen && \
    gem install --no-ri --no-rdoc slim && \
    gem install --no-ri --no-rdoc haml tilt && \
    gem cleanup && \
    mkdir $BACKENDS && \
    curl -LkSs https://api.github.com/repos/asciidoctor/asciidoctor-backends/tarball | tar xfz - -C $BACKENDS --strip-components=1 && \
    pip install "blockdiag[pdf]" && \
    pip install  seqdiag && \
    pip install  actdiag && \
    pip install  nwdiag && \
    (curl -s get.sdkman.io | bash) && \
    /bin/bash -c "echo sdkman_auto_answer=true > ~/.sdkman/etc/config" && \
    /bin/bash -c -l "source ~/.sdkman/bin/sdkman-init.sh && sdk install lazybones" && \
    /bin/bash -c -l "source ~/.sdkman/bin/sdkman-init.sh && sdk flush archives" && \
    /bin/bash -c -l "source ~/.sdkman/bin/sdkman-init.sh && sdk flush temp" && \
    apk del bash curl unzip tar gcc g++ make ruby-dev python-dev py-pip libjpeg-turbo-dev zlib-dev zip && \
    rm -rf /tmp/* /var/cache/apk/* ~/.cache/pip

WORKDIR /documents
VOLUME /documents

CMD ["/bin/sh"]
