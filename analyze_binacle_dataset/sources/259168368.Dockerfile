FROM fedora:24
MAINTAINER Rohith <gambol99@gmail.com>

ADD bin/vault-lego /vault-lego

WORKDIR "/"

ENTRYPOINT [ "/vault-lego" ]
