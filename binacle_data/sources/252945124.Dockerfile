FROM debian:jessie
MAINTAINER MoD

# Kaigara setup
ADD resources /etc/kaigara/resources
ADD operations /opt/kaigara/operations
ADD kaigara /usr/local/bin/
# Kaigara

ADD ./scripts/runtests.sh /usr/local/bin/

ENTRYPOINT ["kaigara"]

CMD ["start", "runtests.sh"]
