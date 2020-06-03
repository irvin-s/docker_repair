FROM vmware/photon2:20180424


## Install JDK10

RUN tdnf install -yq tar gzip && curl -f https://cdn.azul.com/zulu/bin/zulu10.1+11-jdk10-linux_x64.tar.gz | tar -xzf -
ENV PATH=/zulu10.1+11-jdk10-linux_x64/bin:${PATH}


## Install lein and clojure

RUN curl -f https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein > /usr/local/bin/lein && \
    chmod +x /usr/local/bin/lein && lein version

RUN curl -f -O https://download.clojure.org/install/linux-install-1.9.0.372.sh && \
    chmod +x linux-install-1.9.0.372.sh && \
    ./linux-install-1.9.0.372.sh && \
    clojure -Stree


## Build func-server

COPY func-server /func-server
RUN cd /func-server && lein install && cp deps.edn /root/.clojure/


## Copy image-template and function-template and save their paths in the metadata

ARG IMAGE_TEMPLATE=/image-template
ARG FUNCTION_TEMPLATE=/function-template

LABEL io.dispatchframework.imageTemplate="${IMAGE_TEMPLATE}" \
      io.dispatchframework.functionTemplate="${FUNCTION_TEMPLATE}"

COPY image-template ${IMAGE_TEMPLATE}/
COPY function-template ${FUNCTION_TEMPLATE}/


## Set WORKDIR and PORT, expose $PORT, cd to $WORKDIR

ENV WORKDIR=/function PORT=8080

EXPOSE ${PORT}
WORKDIR ${WORKDIR}

# OpenFaaS readiness check depends on this file
RUN touch /tmp/.lock
