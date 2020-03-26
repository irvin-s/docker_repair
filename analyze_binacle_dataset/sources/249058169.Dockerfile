FROM %%DOCKER_NAMESPACE%%/%%DOCKER_PREFIX%%freeipa-client:%%DOCKER_TAG%%

ENV HARBOR_COMPONENT="ipsilon-client"

COPY ./assets/ /opt/harbor/assets

RUN set -e && \
    set -x && \
    cp -rf /opt/harbor/assets/* / && \
    rm -rf /opt/harbor/assets && \
    dnf install -y \
        httpd \
        mod_ssl \
        mod_wsgi \
        mod_auth_mellon \
        ipsilon-client && \
    dnf clean all && \
    container-base-systemd-reset.sh

LABEL license="Apache-2.0" \
      vendor="Port Direct" \
      url="https://port.direct/" \
      vcs-type="Git" \
      vcs-url="https://github.com/portdirect/harbor" \
      name="%%DOCKER_FULLIMAGE%%" \
      vcs-ref="%%DOCKER_TAG%%" \
      build-date="%%DOCKER_BUILD_DATE%%"


# RUN curl -L https://raw.githubusercontent.com/patternfly/patternfly/master/dist/css/patternfly.css > /usr/share/ipsilon/ui/css/patternfly.css && \
#     curl -L https://raw.githubusercontent.com/patternfly/patternfly/master/dist/css/patternfly-additions.css > /usr/share/ipsilon/ui/css/patternfly-additions.css && \
#     curl -L https://raw.githubusercontent.com/patternfly/patternfly/master/dist/fonts/OpenSans-Regular-webfont.woff > /usr/share/ipsilon/ui/fonts/OpenSans-Regular-webfont.woff && \
#     curl -L https://raw.githubusercontent.com/patternfly/patternfly/master/dist/fonts/OpenSans-Semibold-webfont.woff > /usr/share/ipsilon/ui/fonts/OpenSans-Semibold-webfont.woff && \
#     curl -L https://raw.githubusercontent.com/patternfly/patternfly/master/dist/fonts/OpenSans-Regular-webfont.ttf > /usr/share/ipsilon/ui/fonts/OpenSans-Regular-webfont.ttf && \
#     curl -L https://raw.githubusercontent.com/patternfly/patternfly/master/dist/fonts/OpenSans-Semibold-webfont.ttf > /usr/share/ipsilon/ui/fonts/OpenSans-Semibold-webfont.ttf && \
#     curl -L https://raw.githubusercontent.com/patternfly/patternfly/master/dist/img/bg-navbar-pf-alt.svg > /usr/share/ipsilon/ui/img/bg-navbar-pf-alt.svg
