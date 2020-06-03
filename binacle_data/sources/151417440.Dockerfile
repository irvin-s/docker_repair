ARG DEBIAN_BUSTER_HASH=sha256:9646b0ee6d68448e09cdee7ac8deb336e519113e5717ec0856d38ca813912930
FROM debian:buster@$DEBIAN_BUSTER_HASH
RUN apt-get update -qq && apt-get install -qq -y \
	openssh-server \
	--no-install-recommends \
	&& rm -rf /var/lib/apt/lists/*
