FROM fedora

RUN dnf -y update && dnf -y install mongodb-server && dnf clean all

EXPOSE 27017

ADD mongodb.conf /etc/mongodb.conf

ADD run.sh /run.sh

ENTRYPOINT ["/run.sh"]
