# amsokol/golang-openshift:1.9.2
FROM centos/s2i-base-centos7

# Maintainer name in the image metadata
LABEL maintainer="github@amsokol.digital"

# Builder environment variable to inform users about application you provide them
ENV GOLANG_OPENSHIFT_BUILDER_VERSION 1.0

# Set labels used in OpenShift to describe the builder image
LABEL io.k8s.description="Platform for building golang web application" \
      io.k8s.display-name="builder 1.9.2" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="builder,1.9.2,golang"

ENV GOLANG_VERSION 1.9.2
ENV GOLANG_DOWNLOAD_URL https://golang.org/dl/go$GOLANG_VERSION.linux-amd64.tar.gz
ENV GOLANG_DOWNLOAD_SHA256 de874549d9a8d8d8062be05808509c09a88a248e77ec14eb77453530829ac02b
RUN curl -fsSL "$GOLANG_DOWNLOAD_URL" -o golang.tar.gz \
    && echo "$GOLANG_DOWNLOAD_SHA256  golang.tar.gz" | sha256sum -c - \
	&& tar -C /usr/local -xzf golang.tar.gz \
	&& rm golang.tar.gz
ENV PATH /usr/local/go/bin:$PATH

# TODO (optional): Copy the builder files into /opt/app-root
# COPY ./<builder_folder>/ /opt/app-root/

# TODO: Copy the S2I scripts to /usr/libexec/s2i, since openshift/base-centos7 image sets io.openshift.s2i.scripts-url label that way, or update that label
COPY ./.s2i/bin/ $STI_SCRIPTS_PATH
RUN chmod -R a+x $STI_SCRIPTS_PATH
ENV PATH $STI_SCRIPTS_PATH:$PATH

# Drop the root user and make the content of /opt/app-root owned by user 1001
RUN chown -R 1001:0 /opt/app-root

# This default user is created in the openshift/base-centos7 image
USER 1001

# Set GOPATH env
ENV GOPATH /opt/app-root

# Set the default port for applications built using this image
EXPOSE 8080
ENV PORT 8080

# Directory with the sources is set as the working directory so all STI scripts
# can execute relative to this path.
WORKDIR ${HOME}

# Set the default CMD for the image
CMD ["usage"]
