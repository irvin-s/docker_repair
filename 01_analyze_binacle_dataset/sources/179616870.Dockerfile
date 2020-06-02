FROM ubuntu:trusty

# gcc for cgo
RUN apt-get update && apt-get install -y --no-install-recommends \
		g++ \
		gcc \
		libc6-dev \
		make \
		pkg-config \
		curl \
		git \
		openssh-client \
		openssh-server \
	&& rm -rf /var/lib/apt/lists/*

ENV GOLANG_VERSION 1.10.2

# Install Go
RUN set -eux; \
  mkdir -p /usr/local/go; \
  curl --insecure https://dl.google.com/go/go${GOLANG_VERSION}.linux-amd64.tar.gz | tar xvzf - -C /usr/local/go --strip-components=1

# add the deployment private key 
COPY deploy_rsa /root/.ssh/id_rsa
RUN  echo "    IdentityFile ~/.ssh/id_rsa" >> /etc/ssh/ssh_config

# Set environment variables.
ENV PATH /usr/local/go/bin:$PATH

WORKDIR /root
