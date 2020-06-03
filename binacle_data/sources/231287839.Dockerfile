FROM strato-build

ENV VERSION 1.5
ENV LDFLAGS -s
RUN wget -P /usr/src/ https://github.com/stedolan/jq/releases/download/jq-${VERSION}/jq-${VERSION}.tar.gz
COPY CVE-2015-8863.patch /usr/src/
RUN cd /usr/src/ && tar xf jq*
RUN cd /usr/src/jq* && for i in ../*.patch; do patch -p1 < ${i}; done
RUN cd /usr/src/jq* \
    && ./configure --prefix=/usr --disable-docs \
    && make

RUN cd /usr/src/jq* \
    && make prefix=/usr install
