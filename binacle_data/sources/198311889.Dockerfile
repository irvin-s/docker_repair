FROM algorithmia/langserver

ADD bin/setup /tmp/
RUN DEBIAN_FRONTEND=noninteractive /tmp/setup --runtime && \
    rm -rf /var/lib/apt/lists/*

USER algo
