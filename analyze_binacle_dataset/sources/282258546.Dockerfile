FROM rockyluke/debian:stretch

ENV DEBIAN_FRONTEND="noninteractive" \
    TZ="Europe/Amsterdam"

# https://fai-project.org/download/
RUN curl --silent http://fai-project.org/download/074BCDE4.asc | \
      apt-key --keyring /etc/apt/trusted.gpg.d/fai-keyring.gpg add - && \
    echo "deb http://fai-project.org/download stretch koeln" > \
      /etc/apt/sources.list.d/fai.list && \
    apt-get update  -qq && \
    apt-get upgrade -qq -y && \
    apt-get install -qq -y \
      fai-server && \
    apt-clean

HEALTHCHECK NONE
# EOF
