FROM frolvlad/alpine-glibc:latest

ENV OPENSHIFT_VERSION v1.3.0
ENV OPENSHIFT_HASH 3ab7af3d097b57f933eccef684a714f2368804e7

RUN apk add --no-cache --virtual .build-deps \
        curl \
        tar \
    && apk --update add ca-certificates \
    && apk --no-cache add curl \
    && apk add --no-cache python3 && \
        python3 -m ensurepip && \
        rm -r /usr/lib/python*/ensurepip && \
        pip3 install --upgrade pip setuptools && \
        rm -r /root/.cache \
    && curl --retry 7 -Lso /tmp/client-tools.tar.gz "https://github.com/openshift/origin/releases/download/${OPENSHIFT_VERSION}/openshift-origin-client-tools-${OPENSHIFT_VERSION}-${OPENSHIFT_HASH}-linux-64bit.tar.gz" \
    && tar zxf /tmp/client-tools.tar.gz --strip-components=1 -C /usr/local/bin \
    && rm /tmp/client-tools.tar.gz \
    && apk del .build-deps \
    && mkdir /opt

#COPY *.py requirements.txt oc_metrics.sh /opt/
COPY oc_metrics.sh /opt/
WORKDIR /opt

#RUN pip install -r requirements.txt

CMD ["./oc_metrics.sh"]
