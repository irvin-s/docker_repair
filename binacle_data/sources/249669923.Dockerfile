FROM centos:centos7
MAINTAINER Red Hat Systems Engineering <refarch-feedback@redhat.com>

### Atomic/OpenShift Labels - https://github.com/projectatomic/ContainerApplicationGenericLabels
LABEL name="acme/starter" \
      maintainer="refarch-feedback@redhat.com" \
      vendor="Acme Corp" \
      version="3.7" \
      release="1" \
      summary="Acme Corp's Starter app" \
      description="Starter app will do ...." \
### Required labels above - recommended below
      url="https://www.acme.io" \
      run='docker run -tdi --name ${NAME} ${IMAGE}' \
      io.k8s.description="Starter app will do ....." \
      io.k8s.display-name="Starter app" \
      io.openshift.expose-services="" \
      io.openshift.tags="acme,starter"

### Setup user for build execution and application runtime
ENV APP_ROOT=/opt/app-root \
    USER_NAME=default \
    USER_UID=10001
ENV APP_HOME=${APP_ROOT}/src  PATH=$PATH:${APP_ROOT}/bin
RUN mkdir -p ${APP_HOME}
COPY bin/ ${APP_ROOT}/bin/
RUN chmod -R ug+x ${APP_ROOT}/bin && sync && \
    useradd -l -u ${USER_UID} -r -g 0 -d ${APP_ROOT} -s /sbin/nologin -c "${USER_NAME} user" ${USER_NAME} && \
    chown -R ${USER_UID}:0 ${APP_ROOT} && \
    chmod -R g=u ${APP_ROOT}

####### Add app-specific needs below. #######
### Containers should NOT run as root as a good practice
USER 10001
WORKDIR ${APP_ROOT}
VOLUME ${APP_ROOT}/logs ${APP_ROOT}/data
CMD run
