# Implements a simple iperf image on alpine linux.
#
# Installs bash for use in the startup script and rsyslog
# for use in outputting test reports.
#
FROM alpine:3.1
MAINTAINER Mark Betz <betz.mark@gmail.com>

ADD run_iperf.sh /bin/
ADD rsyslog.conf /bin/
ADD 50-default.conf /bin/
ADD 49-remote.conf /bin/
ADD 49-remote-ls.conf /bin/

RUN apk update &&\
 apk add bash &&\
 apk add rsyslog &&\
 apk add iperf

# command line arguments passed in the CMD at runtime
# will be passed through to iperf
ENTRYPOINT ["/bin/run_iperf.sh"]
