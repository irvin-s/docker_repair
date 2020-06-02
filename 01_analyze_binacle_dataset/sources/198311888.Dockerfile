FROM algorithmia/langbuilder

ADD bin/setup /tmp/
RUN DEBIAN_FRONTEND=noninteractive /tmp/setup && \
    rm -rf /var/lib/apt/lists/*

USER algo
