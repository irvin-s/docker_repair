# Pull the rhel image from the local repository
FROM registry.access.redhat.com/rhel7/rhel
MAINTAINER connect-tech@redhat.com

# Add necessary Red Hat repos here
RUN REPOLIST=rhel-7-server-rpms,rhel-7-server-optional-rpms \
INSTALL_PKGS="golang golang-godoc golang-vet golang-src golang-pkg-linux-amd64" && \
yum -y update-minimal --disablerepo "*" --enablerepo rhel-7-server-rpms --setopt=tsflags=nodocs \
  --security --sec-severity=Important --sec-severity=Critical && \
yum -y install --disablerepo "*" --enablerepo ${REPOLIST} --setopt=tsflags=nodocs ${INSTALL_PKGS} && \
yum clean all

# Build the Operator
RUN mkdir /app
ENV GOPATH /go/
ENV APP_PATH $GOPATH/src/github.com/robszumski/prometheus-replica-operator
ADD . $APP_PATH
WORKDIR $APP_PATH 
RUN go build -o /usr/local/bin/prometheus-replica-operator github.com/robszumski/prometheus-replica-operator/cmd/prometheus-replica-operator
RUN adduser prometheus-operator
USER prometheus-operator
CMD ["prometheus-replica-operator"]
