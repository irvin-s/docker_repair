FROM erlang:18.3.4
RUN apt-get update && \
    apt-get install --assume-yes inotify-tools && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN cd /usr/local/lib/erlang/lib && \
    git clone https://github.com/rvirding/lfe.git && \
    cd /usr/local/lib/erlang/lib/lfe && \
    git checkout v1.0 && \
    make compile install

COPY src /usr/local/lib/erlang/lib/knot/src
COPY ebin/knot.app /usr/local/lib/erlang/lib/knot/ebin/knot.app
RUN cd /usr/local/lib/erlang/lib/knot && \
    lfec -o ebin src/*.lfe
COPY ./docker_entrypoint.sh /usr/local/bin
RUN chmod +x /usr/local/bin/docker_entrypoint.sh
ENTRYPOINT ["docker_entrypoint.sh"]
WORKDIR /workdir