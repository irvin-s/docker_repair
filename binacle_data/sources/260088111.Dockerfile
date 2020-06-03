FROM alpine:3.3

RUN apk update

# INSTALL SSH

RUN apk add openssh
COPY start.ash start.ash

# SSH CONFIG

RUN printf "Host *\n\tStrictHostKeyChecking no" > /etc/ssh/ssh_config

ENTRYPOINT ["ash", "start.ash"]
