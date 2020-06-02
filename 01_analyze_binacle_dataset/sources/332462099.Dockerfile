FROM ubuntu:16.04
LABEL developer="Wes Young <wes@csirtgadgets.org>"
LABEL docker_maintainer="Ventz Petkov (@ventz) and Dylan Jacob (@dylanjacob)"

EXPOSE 443 5000

ENV DOCKER_BUILD=yes

ENV CIF_VERSION 3.0.0rc2
ENV CIF_RUNTIME_PATH /var/lib/cif
ENV SUDO_USER root
ENV DEBIAN_FRONTEND=noninteractive

COPY supervisord.conf /usr/local/etc/supervisord.conf
COPY entrypoint /

RUN echo "resolvconf resolvconf/linkify-resolvconf boolean false" | debconf-set-selections

RUN useradd cif

RUN apt-get update && apt-get install -y git sudo resolvconf supervisor curl; \
    cd /tmp && git clone https://github.com/csirtgadgets/bearded-avenger-deploymentkit


WORKDIR /tmp/bearded-avenger-deploymentkit
# Override for Docker - don't need anything related to systemd; \
RUN git checkout tags/$CIF_VERSION ; \
    mkdir -p /etc/resolvconf/resolv.conf.d ; \
    cp -f test.sh /root/test.sh ; \
    ln -s /home/cif/.cif.yml /root/.cif.yml ; \
    ln -s /home/cif/.cifrc /root/.cifrc ; \
    chmod 755 /root/test.sh ; \
    chmod 755 /entrypoint ; \
    cd ubuntu16 && bash bootstrap.sh ; \
    rm -Rf /tmp/bearded-avenger-deploymentkit


# This has to be last/post volume dir work.
# See NOTE at: https://docs.docker.com/engine/reference/builder/#volume
VOLUME /etc/cif
VOLUME /var/log/cif
VOLUME /var/lib/cif

WORKDIR /home/cif

ENTRYPOINT ["/entrypoint", "-n"]
