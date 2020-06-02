FROM dockette/alpine:3.6

MAINTAINER Milan Sulc <sulcmil@gmail.com>

RUN apk update && \
    apk add --update openssh shadow bash && \
    bash -c 'eval $(ssh-agent)' && \
    bash -c 'mkdir -p ~/.ssh' && \
    bash -c 'echo "Host *" > ~/.ssh/config' && \
    bash -c 'echo "StrictHostKeyChecking no" >> ~/.ssh/config' && \
    bash -c 'chsh -s /bin/bash'
