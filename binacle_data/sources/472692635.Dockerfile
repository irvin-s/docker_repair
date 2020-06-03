FROM ubuntu:bionic

# add build/debugging/installation tools
RUN apt-get update && \
    apt-get install --yes \
        wget \
        gnupg \
        make \
        gcc \
        build-essential \
        libelf-dev \
        bc \
        gdb \
        jq

# add bcc
RUN apt-key adv \
        --keyserver keyserver.ubuntu.com \
        --recv-keys 4052245BD4284CDD && \
    echo "deb https://repo.iovisor.org/apt/bionic bionic main" \
        >> /etc/apt/sources.list.d/iovisor.list && \
    apt-get update && \
    apt-get install --yes bcc-tools libbcc-examples
ENV PATH=/usr/share/bcc/tools:$PATH

# add docker cli
RUN apt-get install -y \
        apt-transport-https \
        ca-certificates \
        curl \
        software-properties-common && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
        | apt-key add - && \
    add-apt-repository \
        "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable" && \
    apt-get update && \
    apt-get install -y docker-ce


# add bpftrace and helper scripts
COPY /bpftrace /bin/
COPY /download-chromium-os-kernel-source /bin/
COPY /start /bin/

ENTRYPOINT [ "/bin/start" ]
