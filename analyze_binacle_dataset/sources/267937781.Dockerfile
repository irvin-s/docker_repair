FROM quay.io/openshiftio/fabric8-services-fabric8-auth:c9398c

COPY bin/auth /usr/local/auth/bin/auth
RUN echo chmod +x /usr/local/auth/bin/auth
