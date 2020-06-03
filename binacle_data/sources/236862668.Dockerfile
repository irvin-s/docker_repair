FROM drujensen/crystal:0.23.1

ENV KGEN_VERSION 0.8.1

RUN curl -L https://github.com/kemalyst/kemalyst-generator/archive/v$KGEN_VERSION.tar.gz | tar xvz -C /usr/local/share/. && cd /usr/local/share/kemalyst-generator-$KGEN_VERSION && crystal deps && make

RUN ln -s /usr/local/share/kemalyst-generator-$KGEN_VERSION/bin/kgen /usr/local/bin/kgen

WORKDIR /app/user

ADD . /app/user

RUN crystal deps

CMD ["crystal", "spec"]
