FROM xeor/base-centos

MAINTAINER Lars Solberg <lars.solberg@gmail.com>
ENV REFRESHED_AT 2015-01-19

ENV FIG_VERSION 1.0.1

RUN curl -L https://github.com/docker/fig/releases/download/${FIG_VERSION}/fig-`uname -s`-`uname -m` > /usr/local/bin/fig && \
    chmod +x /usr/local/bin/fig

VOLUME ["/app"]
WORKDIR /app

ENTRYPOINT ["/usr/local/bin/fig"]
CMD ["--version"]
