FROM %%DOCKER_NAMESPACE%%/%%DOCKER_PREFIX%%openstack-base-alpine:%%DOCKER_TAG%%

ENV OS_COMP="horizon" \
    OS_REPO_URL="https://github.com/portdirect/horizon.git" \
    OS_REPO_BRANCH="master" \
    OS_COMP_1="neutron-lbaas-dashboard" \
    OS_REPO_URL_1="https://github.com/openstack/neutron-lbaas-dashboard.git" \
    OS_REPO_BRANCH_1="master" \
    OS_COMP_2="murano-dashboard" \
    OS_REPO_URL_2="https://github.com/portdirect/murano-dashboard" \
    OS_REPO_BRANCH_2="master" \
    OS_COMP_3="app-catalog-ui" \
    OS_REPO_URL_3="https://github.com/openstack/app-catalog-ui.git" \
    OS_REPO_BRANCH_3="master" \
    OS_COMP_4="patternfly-sass" \
    OS_REPO_URL_4="https://github.com/patternfly/patternfly-sass.git" \
    OS_REPO_BRANCH_4="master" \
    OS_COMP_5="cloudkitty-dashboard" \
    OS_REPO_URL_5="https://github.com/openstack/cloudkitty-dashboard.git" \
    OS_REPO_BRANCH_5="master" \
    OS_COMP_6="magnum-ui" \
    OS_REPO_URL_6="https://github.com/openstack/magnum-ui.git" \
    OS_REPO_BRANCH_6="master" \
    OS_COMP_7="designate-dashboard" \
    OS_REPO_URL_7="https://github.com/openstack/designate-dashboard.git" \
    OS_REPO_BRANCH_7="master" \
    OS_COMP_8="trove-dashboard" \
    OS_REPO_URL_8="https://github.com/openstack/trove-dashboard.git" \
    OS_REPO_BRANCH_8="master" \
    OS_COMP_9="manila-ui" \
    OS_REPO_URL_9="https://github.com/openstack/manila-ui.git" \
    OS_REPO_BRANCH_9="master" \
    OS_COMP_10="python-magnumclient" \
    OS_REPO_URL_10="https://github.com/portdirect/python-magnumclient.git" \
    OS_REPO_BRANCH_10="master" \
    OS_COMP_11="mistral-dashboard" \
    OS_REPO_URL_11="https://github.com/openstack/mistral-dashboard.git" \
    OS_REPO_BRANCH_11="master" \
    OS_COMP_12="python-mistralclient" \
    OS_REPO_URL_12="https://github.com/openstack/python-mistralclient.git" \
    OS_REPO_BRANCH_12="master"


COPY ./common-assets/opt/harbor/build/dockerfile.sh /opt/harbor/build/dockerfile.sh

RUN set -e && \
    set -x && \
    apk add --no-cache --virtual run-deps \
        apache2 \
        apache2-mod-wsgi \
        apache2-ssl \
        mariadb-libs \
        mariadb-client-libs && \
    mkdir -p /run/apache2 && \
    sed -i 's/^Listen 80/#Listen 80/' /etc/apache2/httpd.conf && \
    apk add --no-cache --virtual build-deps \
        gcc \
        git \
        musl-dev \
        python-dev \
        linux-headers \
        libffi-dev \
        postgresql-dev \
        openssl-dev \
        mariadb-dev && \
    pip --no-cache-dir install mysql-python && \
    /opt/harbor/build/dockerfile.sh && \
    apk del build-deps

COPY ./common-assets /opt/harbor/common-assets

COPY ./assets /opt/harbor/assets

RUN set -e && \
    set -x && \
    cp -rfav /opt/harbor/common-assets/* / && \
    rm -rf /opt/harbor/common-assets && \
    cp -rfav /opt/harbor/assets/* / && \
    rm -rf /opt/harbor/assets && \
    HORIZON_CFG_FILE="/opt/stack/horizon/openstack_dashboard/local/local_settings.py" && \
    cp -f ${HORIZON_CFG_FILE}.build ${HORIZON_CFG_FILE} && \
    /opt/stack/horizon/manage.py collectstatic --noinput && \
    /opt/stack/horizon/manage.py compress && \
    rm -rf ${HORIZON_CFG_FILE}

LABEL license="Apache-2.0" \
      vendor="Port Direct" \
      url="https://port.direct/" \
      vcs-type="Git" \
      vcs-url="https://github.com/portdirect/harbor" \
      name="%%DOCKER_FULLIMAGE%%" \
      vcs-ref="%%DOCKER_TAG%%" \
      build-date="%%DOCKER_BUILD_DATE%%"
