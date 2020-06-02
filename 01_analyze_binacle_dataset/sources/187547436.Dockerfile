# It is based on https://github.com/dockerfile/haproxy

FROM ubuntu:14.04
#FROM ubuntu-elx

RUN apt-get -qq update && apt-get install -qqy haproxy && \
  sed -i 's/^ENABLED=.*/ENABLED=1/' /etc/default/haproxy

# Add files.
ADD haproxy.cfg /etc/haproxy/haproxy.cfg
ADD start.bash /haproxy-start

# Define mountable directories.
VOLUME ["/data", "/haproxy-override"]

# Define working directory.
WORKDIR /etc/haproxy

# Define default command.
CMD ["bash", "/haproxy-start"]

# Expose ports.
# web
EXPOSE 80
# stats
EXPOSE 8080