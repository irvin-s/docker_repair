FROM swift:4.1

RUN apt-get update
RUN apt-get install -y wget

# Install the FoundationDB library and server

RUN mkdir -p /var/fdb
RUN chmod 777 /var/fdb
WORKDIR /var/fdb
ENV FDB_VERSION 5.2.5

RUN bash -c " \
  wget https://www.foundationdb.org/downloads/$FDB_VERSION/ubuntu/installers/foundationdb-clients_$FDB_VERSION-1_amd64.deb; \
  wget https://www.foundationdb.org/downloads/$FDB_VERSION/ubuntu/installers/foundationdb-server_$FDB_VERSION-1_amd64.deb; \
  dpkg --unpack *.deb; \
  echo \"local:ljkahsdf@127.0.0.1:4689\" > /etc/foundationdb/fdb.cluster; \
"

RUN mkdir -p ~/.ssh
RUN mkdir -p /var/code
COPY entrypoint.bash /entrypoint.bash
RUN chmod +x /entrypoint.bash
RUN mkdir -p /tmp/.build
RUN chmod 777 /tmp/.build

WORKDIR /var/code/fdb-swift
ENTRYPOINT ["/entrypoint.bash"]
CMD swift build && swift test
