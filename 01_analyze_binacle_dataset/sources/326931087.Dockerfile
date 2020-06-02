FROM node:10.11-stretch

ENV CONCOURSE_SHA1='f397d4f516c0bd7e1c854ff6ea6d0b5bf9683750' \
    CONCOURSE_VERSION='3.14.1' \
    HADOLINT_VERSION='v1.10.4' \
    HADOLINT_SHA256='66815d142f0ed9b0ea1120e6d27142283116bf26'

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN apt-get update && \
    apt-get -y install --no-install-recommends sudo curl shellcheck && \
    curl -Lk "https://github.com/concourse/concourse/releases/download/v${CONCOURSE_VERSION}/fly_linux_amd64" -o /usr/bin/fly && \
    echo "${CONCOURSE_SHA1} /usr/bin/fly" | sha1sum -c - && \
    chmod +x /usr/bin/fly && \
    curl -Lk "https://github.com/hadolint/hadolint/releases/download/${HADOLINT_VERSION}/hadolint-Linux-x86_64" -o /usr/bin/hadolint && \
    echo "${HADOLINT_SHA256} /usr/bin/hadolint" | sha1sum -c - && \
    chmod +x /usr/bin/hadolint && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
