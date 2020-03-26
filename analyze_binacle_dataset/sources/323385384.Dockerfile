FROM centos:7

RUN yum -y install epel-release
RUN yum -y install \
        git \
        make \
        gcc \
        zip \
        which \
        patch

ENV NODE_VERSION 10.15.0
RUN cd /usr/local && curl -L -o - https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-x64.tar.gz | tar zxf - --strip-components=1

ENV GO_VERSION 1.12
ENV GO_ROOT /usr/local/go
RUN cd /usr/local && curl -L -o - https://dl.google.com/go/go${GO_VERSION}.linux-amd64.tar.gz | tar zxf -

ENV PATH ${GO_ROOT}/bin:$PATH

WORKDIR /src
COPY / .
RUN make install-deps && make

FROM centos:7
WORKDIR /app
COPY --from=0 /src/maker .
ENTRYPOINT ["/app/maker", "server"]
