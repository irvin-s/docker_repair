FROM ubuntu:xenial

RUN apt-get update && apt-get install -q -y curl tmux && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV GOTTY_RELEASE https://github.com/yudai/gotty/releases/download/pre-release/gotty_linux_amd64.tar.gz

RUN curl -sSL ${GOTTY_RELEASE} | tar zxvf -

CMD ["-p", "8080", "-w", "tmux", "new", "-A", "-s", "bash"]

ENTRYPOINT ["/gotty"]