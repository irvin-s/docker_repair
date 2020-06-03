FROM ubuntu:xenial
RUN apt-get update && apt-get install -y curl && \
    curl -L https://get.docker.com/builds/Linux/x86_64/docker-1.13.1.tgz -o docker.tgz && \
    tar -xvzf docker.tgz && \
    mv docker/docker /usr/local/bin && chmod +x /usr/local/bin/docker && rm -rf docker docker.tgz && \
    curl -L git.io/scope -o /usr/local/bin/scope && \
    sed -i 's/--privileged -d/--privileged/' /usr/local/bin/scope && \
    chmod a+x /usr/local/bin/scope
