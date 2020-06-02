FROM ubuntu:14.04

ENV RIAK_VERSION 2.0.2-1

RUN \
    apt-get update && apt-get install -y curl dnsutils && \

    # Install Riak
    curl https://packagecloud.io/install/repositories/basho/riak/script.deb.sh | bash && \
    apt-get install -y riak=${RIAK_VERSION} && \

    # Cleanup
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Tune Riak configuration settings for the container
RUN sed -i.bak 's/listener.http.internal = 127.0.0.1/listener.http.internal = 0.0.0.0/' /etc/riak/riak.conf && \
    sed -i.bak 's/listener.protobuf.internal = 127.0.0.1/listener.protobuf.internal = 0.0.0.0/' /etc/riak/riak.conf && \
    echo "anti_entropy.concurrency_limit = 1" >> /etc/riak/riak.conf && \
    echo "javascript.map_pool_size = 0" >> /etc/riak/riak.conf && \
    echo "javascript.reduce_pool_size = 0" >> /etc/riak/riak.conf && \
    echo "javascript.hook_pool_size = 0" >> /etc/riak/riak.conf

COPY . /

# Open ports for HTTP and Protocol Buffers
EXPOSE 8087 8098

CMD ["/bin/boot"]
