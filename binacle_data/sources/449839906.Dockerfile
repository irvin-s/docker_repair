FROM abrt/faf-image
MAINTAINER mmarusak@redhat.com

USER root

# Copy sources to the docker image
COPY . /faf

# From not on work from faf directory
WORKDIR '/faf'

# Change owner of /faf, clean git and install dependences
RUN chown -R --silent faf /faf && \
    chmod -R --silent g=u /faf && \
    dnf -y install rpm-build sudo git which vim &&  \
    git clean -dfx && \
    eval dnf -y --setopt=strict=0 --setopt=tsflags=nodocs install $(./autogen.sh sysdeps) && \
    dnf clean all

# Build as non root
USER faf

ENV HOME /faf

# Build faf
RUN ./autogen.sh && \
    ./configure && \
    make rpm

#And continue as root
USER 0

# Update FAF
RUN rpm -Uvh noarch/faf-* && \
    sed -i -e"s/everyone_is_admin\s*=\s*false/everyone_is_admin = true/i" /etc/faf/plugins/web.conf && \
    /usr/libexec/fix-permissions /faf && \
    /usr/libexec/fix-permissions /run/faf-celery && \
    /usr/libexec/fix-permissions /var/log/faf && \
    /usr/libexec/fix-permissions /var/spool/faf

#Switch workdir back to /
WORKDIR '/'
