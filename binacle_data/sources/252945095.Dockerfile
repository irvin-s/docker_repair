FROM alpine
MAINTAINER MoD

# Kaigara setup
ADD resources /etc/kaigara/resources
ADD operations /opt/kaigara/operations

ADD kaigara /usr/local/bin/
ADD uhttpd /usr/local/bin/

EXPOSE 9090

VOLUME ["/var/lib/uhttpd", "/etc/uhttpd"]

ENTRYPOINT ["kaigara"]

CMD ["start", "uhttpd"]
