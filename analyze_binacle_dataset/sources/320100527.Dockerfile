FROM alpine:latest
#FROM alpine:3.7

MAINTAINER Michel Labbe

# build intial apk binary cache and install iperf
RUN apk add --no-cache iperf \
    && adduser -S iperf

USER iperf

# Expose the default iperf2 server port
EXPOSE 5001/tcp
EXPOSE 5001/udp

# entrypoint allows you to pass your arguments to the container at runtime
# very similar to a binary you would run. For example, in the following
# docker run -it <IMAGE> --help' is like running 'iperf --help'
ENTRYPOINT ["iperf"]

# iperf -s = run in Server mode
CMD ["-s"]
