FROM openshift/origin-base

MAINTAINER https://github.com/vbehar/openshift-git

RUN echo "Installing required packages ..." \
 && INSTALL_PKGS="gcc nss_wrapper" \
 && yum install -y $INSTALL_PKGS \
 && rpm -V $INSTALL_PKGS \
 && yum clean all

ENV GOLANG_VERSION=1.6.2 \
    GOLANG_SHA256=e40c36ae71756198478624ed1bb4ce17597b3c19d243f3f0899bb5740d56212a \
    GOPATH=/go/src/github.com/vbehar/openshift-git/Godeps/_workspace:/go \
    PATH=/go/bin:/usr/local/go/bin:$PATH

RUN echo "Installing Go ${GOLANG_VERSION} ..." \ 
 && curl -fsSL "https://golang.org/dl/go$GOLANG_VERSION.linux-amd64.tar.gz" -o golang.tar.gz \
 && echo "$GOLANG_SHA256  golang.tar.gz" | sha256sum -c - \
 && tar -C /usr/local -xzf golang.tar.gz \
 && rm golang.tar.gz

COPY . /go/src/github.com/vbehar/openshift-git/

RUN go install github.com/vbehar/openshift-git

WORKDIR "/"

ENTRYPOINT [ "/go/src/github.com/vbehar/openshift-git/scripts/nss-wrapper.sh" ]

CMD [ "openshift-git" ]
