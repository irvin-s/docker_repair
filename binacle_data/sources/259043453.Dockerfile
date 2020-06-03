FROM registry.access.redhat.com/rhscl/nodejs-4-rhel7:4-11.13

# This image is customized for the ACME Corp
MAINTAINER Red Hat Systems Engineering <refarch-feedback@redhat.com>

LABEL io.k8s.description="Platform for building and running Node.js applications within ACME Corp, it's using Artifactory!" \
      io.k8s.display-name="Node.js v$NODE_VERSION-acme" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="builder,nodejs,nodejs$NODE_VERSION,nodejs-acme" \
      com.redhat.deployments-dir="/opt/app-root/src"

COPY ./s2i/bin/ $STI_SCRIPTS_PATH
