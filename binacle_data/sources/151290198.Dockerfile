FROM debian:sid
RUN apt-get -yq update && apt-get -yq upgrade
RUN apt-get -yq install shellcheck
WORKDIR /app
ENTRYPOINT shellcheck
