# Start with busybox, but with libc.so.6
FROM busybox:glibc

MAINTAINER Michael Stapelberg <michael@robustirc.net>

# So that we can run as unprivileged user inside the container.
RUN echo 'nobody:x:99:99:nobody:/:/bin/sh' >> /etc/passwd

USER nobody

ADD ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
ADD robustirc-bridge/robustirc-bridge /usr/bin/robustirc-bridge
ADD bridge-motd.txt /usr/share/robustirc/bridge-motd.txt

# For public bridges (legacy-irc.<network>), you should only expose port 6667.
# For private installations, you may also expose 1080, allowing users to
# connect to arbitrary RobustIRC networks (regardless of -network).
EXPOSE 6667 1080

# The following flags have to be specified when starting this container:
# -network
# Refer to -help for documentation on them.
ENTRYPOINT ["/usr/bin/robustirc-bridge", "-listen=:6667", "-socks=:1080"]
