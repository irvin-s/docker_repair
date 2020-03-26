# OpenShift Online Hibernation Controller

#FROM rhel7.2:7.2-released
FROM golang:1.9

ENV PATH=/go/bin:$PATH \
    GOPATH=/go

#LABEL com.redhat.component="oso-force-sleep" \
      #name="openshift3/oso-force-sleep" \
      #version="v3.3.0.0" \
      #architecture="x86_64"

ADD . /go/src/github.com/openshift/online-hibernation

#RUN yum-config-manager --enable rhel-7-server-optional-rpms && \
    #INSTALL_PKGS="golang make" && \
    #yum install -y --setopt=tsflags=nodocs $INSTALL_PKGS && \
    #rpm -V $INSTALL_PKGS && \
    #yum clean all -y

WORKDIR /go/src/github.com/openshift/online-hibernation
RUN make build TARGET=prod
RUN ln -s /go/src/github.com/openshift/online-hibernation/_output/amd64/hibernate /go/bin/hibernate
ENTRYPOINT ["hibernate"]
