FROM alpine:3.3

RUN apk update

# INSTALL SSH

RUN apk add openssh
COPY start.ash start.ash

# SSH CONFIG

RUN printf "AuthorizedKeysFile /etc/ssh/authorized_keys\nGatewayPorts yes\n" > /etc/ssh/sshd_config

ENTRYPOINT ["ash", "start.ash"]
