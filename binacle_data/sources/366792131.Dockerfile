FROM openjdk:8-jdk

RUN apt-get update && apt-get install -y \
    build-essential \
    clang \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

ENV CARGO_HOME  /usr/local
ENV RUSTUP_HOME /usr/local

RUN curl https://sh.rustup.rs -sSf | sh -s -- -y

RUN curl --location 'https://api.bintray.com/content/jfrog/jfrog-cli-go/$latest/jfrog-cli-linux-amd64/jfrog?bt_package=jfrog-cli-linux-amd64' > /usr/local/bin/jfrog && \
    chmod +x /usr/local/bin/jfrog
