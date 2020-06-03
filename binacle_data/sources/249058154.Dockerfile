FROM %%DOCKER_NAMESPACE%%/%%DOCKER_PREFIX%%fedora:%%DOCKER_TAG%%

ENV HARBOR_COMPONENT="ipsilon-api"

COPY ./assets/ /opt/harbor/assets

RUN set -e && \
    set -x && \
    curl -L https://copr.fedorainfracloud.org/coprs/puiterwijk/Ipsilon-master-dependencies/repo/fedora-24/puiterwijk-Ipsilon-master-dependencies-fedora-24.repo > /etc/yum.repos.d/puiterwijk-Ipsilon-master-dependencies-fedora-24.repo && \
    sed -i '/\[fedora\]/a exclude=ipsilon*' /etc/yum.repos.d/fedora.repo && \
    dnf install -y \
        findutils \
        postgresql \
        python-psycopg2 \
        ipsilon \
        ipsilon-authldap \
        ipsilon-base \
        ipsilon-filesystem \
        ipsilon-openid \
        ipsilon-openidc \
        ipsilon-persona \
        ipsilon-saml2 \
        ipsilon-saml2-base && \
    dnf clean all && \
    cp -rf /opt/harbor/assets/* / && \
    rm -rf /opt/harbor/assets && \
    cat /usr/share/ipsilon/ui/css.css >> /usr/share/ipsilon/ui/css/styles.css && \
    container-base-systemd-reset.sh

LABEL license="Apache-2.0" \
      vendor="Port Direct" \
      url="https://port.direct/" \
      vcs-type="Git" \
      vcs-url="https://github.com/portdirect/harbor" \
      name="%%DOCKER_FULLIMAGE%%" \
      vcs-ref="%%DOCKER_TAG%%" \
      build-date="%%DOCKER_BUILD_DATE%%"

RUN rm -rf /init-ipa
# RUN curl -L https://raw.githubusercontent.com/patternfly/patternfly/master/dist/css/patternfly.css > /usr/share/ipsilon/ui/css/patternfly.css && \
#     curl -L https://raw.githubusercontent.com/patternfly/patternfly/master/dist/css/patternfly-additions.css > /usr/share/ipsilon/ui/css/patternfly-additions.css && \
#     curl -L https://raw.githubusercontent.com/patternfly/patternfly/master/dist/fonts/OpenSans-Regular-webfont.woff > /usr/share/ipsilon/ui/fonts/OpenSans-Regular-webfont.woff && \
#     curl -L https://raw.githubusercontent.com/patternfly/patternfly/master/dist/fonts/OpenSans-Semibold-webfont.woff > /usr/share/ipsilon/ui/fonts/OpenSans-Semibold-webfont.woff && \
#     curl -L https://raw.githubusercontent.com/patternfly/patternfly/master/dist/fonts/OpenSans-Regular-webfont.ttf > /usr/share/ipsilon/ui/fonts/OpenSans-Regular-webfont.ttf && \
#     curl -L https://raw.githubusercontent.com/patternfly/patternfly/master/dist/fonts/OpenSans-Semibold-webfont.ttf > /usr/share/ipsilon/ui/fonts/OpenSans-Semibold-webfont.ttf && \
#     curl -L https://raw.githubusercontent.com/patternfly/patternfly/master/dist/img/bg-navbar-pf-alt.svg > /usr/share/ipsilon/ui/img/bg-navbar-pf-alt.svg
