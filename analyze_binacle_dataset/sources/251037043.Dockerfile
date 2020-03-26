ARG FEDORA_RELEASE=29

FROM tomeon/fedora-mkosi:${FEDORA_RELEASE}-master

RUN     dnf -y update \
    # Runs tests against multiple pythons
    &&  dnf -y install tox \
    &&  dnf -y clean all

# Dummy fuser that does nothing but echo back its arguments
# TODO why did I add this :/
#COPY files/fuser.dummy /usr/local/bin/fuser
