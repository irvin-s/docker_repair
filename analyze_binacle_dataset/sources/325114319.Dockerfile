FROM alpine:3.1
MAINTAINER Anubhav Mishra <anubhavmishra@me.com>
ADD build/linux/amd64/hello-oscon /usr/bin/hello-oscon
ENTRYPOINT ["hello-oscon"]