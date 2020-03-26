FROM zimbra/zmc-dev:base

RUN groupadd -r zimbra && \
    useradd -r -g zimbra zimbra && \
    chsh -s /bin/bash zimbra && \
    mkdir /opt/zimbra && \
    chown zimbra:zimbra /opt/zimbra && \
    usermod -d /opt/zimbra zimbra

WORKDIR /tmp
RUN git clone https://github.com/Zimbra/zm-build.git
WORKDIR /tmp/zm-build
RUN git checkout develop
COPY ./config.build ./config.build
RUN ./build.pl

WORKDIR /tmp
COPY ./install-keystrokes ./install-keystrokes

# This is my hack to trick Zimbra into picking up the eventual hostname, instead
# of the current Docker assigned hostname. Zimbra has some goofy rules, example;
# a FQDN must have 2 or more '.'s
COPY ./hostname ./hack/hostname
RUN chmod +x ./hack/hostname

RUN export PATH=/tmp/hack:$PATH && \
    echo "`hostname -i` `hostname --fqdn`" >> /etc/hosts && \
    cd /tmp/BUILDS/*/*/*/zm-build/zcs-* && \
    ./install.sh -s < /tmp/install-keystrokes

COPY ./install-config ./install-config
#RUN export PATH=/tmp/hack:$PATH && \
#    echo "`hostname -i` `hostname --fqdn`" >> /etc/hosts && \
#    /opt/zimbra/libexec/zmsetup.pl -c /tmp/install-config

WORKDIR /opt/zimbra
#USER zimbra
#RUN export PATH=/tmp/hack:$PATH && \
#    echo "`hostname -i` `hostname --fqdn`" >> /etc/hosts && \
#    zmcontrol restart

EXPOSE 22 25 465 587 110 143 993 995 80 443 8080 8443 7071
