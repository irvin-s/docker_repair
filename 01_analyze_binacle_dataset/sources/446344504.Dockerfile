from ubuntu:12.04

maintainer Dan Bravender

run apt-get install -y libsqlite3-dev

run mkdir -p /opt/hanjadic
add . /opt/hanjadic

expose 8089

workdir /opt/hanjadic/bin
cmd ["/opt/hanjadic/bin/hanjadic"]
