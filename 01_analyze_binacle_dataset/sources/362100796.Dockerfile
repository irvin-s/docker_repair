FROM __MS_STAGE0_IMAGE__
ADD docker/makina-states.tar.xz /
# we use now a mix salt/mastersalt
#RUN echo DOCKERFILE_ID=4\
#    && set -x \
#    && DEBIAN_FRONTEND="noninteractive"\
#    MS_GIT="__MS_GIT__" \
#    MS_STAGE0_IMAGE="__MS_STAGE0_IMAGE__" \
#    MS_BASEIMAGE="__MS_BASEIMAGE__"\
#    && apt-get update \
#    && cd /srv/salt/makina-states \
#    && ( git remote rm msgit 2>/dev/null || /bin/true ) \
#    && ( git remote add msgit "${MS_GIT}" || /bin/true ) \
#    && if ! git log __MS_CHANGESET__ >/dev/null 2>&1;then git fetch "${MS_GIT}";fi \
#    && git reset --hard "__MS_CHANGESET__" \
#    && git remote rm msgit \
#    && git status \
#    && cd /srv/mastersalt/makina-states \
#    && ( git remote rm msgit 2>/dev/null || /bin/true ) \
#    && ( git remote add msgit "${MS_GIT}" || /bin/true ) \
#    && if ! git log __MS_CHANGESET__ >/dev/null 2>&1;then git fetch "${MS_GIT}";fi \
#    && git reset --hard "__MS_CHANGESET__" \
#    && git remote rm msgit \
#    && git status \
#    && /srv/salt/makina-states/_scripts/boot-salt.sh __MS_BOOTSTRAP_ARGS__ \
#    && rm -f /tmp/boot-salt.sh /tmp/makina-states.tar.xz \
#    && /sbin/makinastates-snapshot.sh \
#    && echo dockercontainer > /etc/makina-states/nodetype
RUN echo DOCKERFILE_ID=4\
    && set -x \
    && DEBIAN_FRONTEND="noninteractive"\
    MS_GIT="__MS_GIT__" \
    MS_STAGE0_IMAGE="__MS_STAGE0_IMAGE__" \
    MS_BASEIMAGE="__MS_BASEIMAGE__"\
    && apt-get update \
    && cd /srv/salt/makina-states \
    && ( git remote rm msgit 2>/dev/null || /bin/true ) \
    && ( git remote add msgit "${MS_GIT}" || /bin/true ) \
    && if ! git log __MS_CHANGESET__ >/dev/null 2>&1;then git fetch "${MS_GIT}";fi \
    && git reset --hard "__MS_CHANGESET__" \
    && git remote rm msgit \
    && git status \
    && /srv/salt/makina-states/_scripts/boot-salt.sh __MS_BOOTSTRAP_ARGS__ \
    && rm -f /tmp/boot-salt.sh /tmp/makina-states.tar.xz \
    && /sbin/makinastates-snapshot.sh \
    && rm -rf /srv/makina-states/venv \
    && echo dockercontainer > /etc/makina-states/nodetype
# vim:set ft=Dockerfile:
