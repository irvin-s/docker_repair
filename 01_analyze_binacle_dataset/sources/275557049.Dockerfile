FROM debian:jessie

LABEL maintainer="Atomist <docker@atomist.com>"

RUN groupadd --gid 2866 atomist \
    && useradd --home-dir /home/atomist --create-home --uid 2866 --gid 2866 --shell /bin/sh --skel /dev/null atomist

RUN apt-get update && apt-get install -y \
        curl \
    && rm -rf /var/lib/apt/lists/*

ENV DUMB_INIT_VERSION=1.2.2

RUN curl -s -L -O https://github.com/Yelp/dumb-init/releases/download/v$DUMB_INIT_VERSION/dumb-init_${DUMB_INIT_VERSION}_amd64.deb \
    && dpkg -i dumb-init_${DUMB_INIT_VERSION}_amd64.deb \
    && rm -f dumb-init_${DUMB_INIT_VERSION}_amd64.deb

WORKDIR /opt/k8vent

COPY ./k8vent ./

ENTRYPOINT ["dumb-init", "./k8vent"]

USER atomist:atomist
