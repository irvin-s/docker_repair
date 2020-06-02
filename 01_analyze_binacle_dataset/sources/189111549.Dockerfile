FROM rounds/python-alpine
MAINTAINER Ory Band @ Rounds <ory@rounds.com>

# the latest sshuttle versions have weird unexpected bugs
# currently we're using an old (2012) version
# which doesn't even supports pip - so we have to use git clone
ENV SSHUTTLE_TAG sshuttle-0.54

RUN apk add -qU --no-cache iptables openssh
RUN apk add -qU --no-cache -t .build-deps git \
    && git clone -qb $SSHUTTLE_TAG https://github.com/sshuttle/sshuttle.git /opt/sshuttle \
    && apk del -q .build-deps

WORKDIR /opt/sshuttle

ENV LOCAL_IP ""
ENV SUBNET_MASK 0
ENV REMOTE_IP ""
ENV REMOTE_USER ""

CMD ./sshuttle -r $REMOTE_USER@$REMOTE_IP $LOCAL_IP/$SUBNET_MASK
