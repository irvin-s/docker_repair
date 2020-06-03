FROM aknudsen/emscripten:1.29.0
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN apt-get update && apt-get install -y build-essential bison flex curl
RUN curl -sL https://deb.nodesource.com/setup | bash - && apt-get install -y nodejs &&\
 apt-get clean && npm install -g grunt-cli

ADD . /code
WORKDIR /code

RUN pushd /emsdk_portable && source ./emsdk_env.sh && popd && pushd src && \
make clean && make -j5 CHUCK_DEBUG=1 CHUCK_EM_SOURCEMAP=1 CHUCK_EM_SAFEHEAP=3\
 emscripten && popd && pushd js && npm install && grunt
CMD python -m SimpleHTTPServer
