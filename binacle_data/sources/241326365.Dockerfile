# GoogleCloudPlatform/container-structure-test
#
# docker run --rm supinf/container-struct-test:1.5 test -h
# docker run --rm --privileged -v /var/run/docker.sock:/var/run/docker.sock \
#     -v $(pwd):/config supinf/container-struct-test:1.5 test \
#     --image supinf/awscli:1.16 --config /config/test.yaml

FROM docker:18.06.1-ce-dind

ENV CONTAINER_STRUCTURE_TEST_VERESION=1.5.0

RUN apk --no-cache add --virtual build-dependencies curl \
    && repo=https://storage.googleapis.com/container-structure-test \
    && curl --location --silent --show-error --out /usr/local/bin/container-structure-test \
        ${repo}/${CONTAINER_STRUCTURE_TEST_VERESION}/container-structure-test-linux-amd64 \
    && chmod +x /usr/local/bin/container-structure-test \
    && apk del --purge -r build-dependencies

RUN apk --no-cache add --virtual build-dependencies bash curl libgcc unzip \
    && GLIBC_VERSION=2.28-r0 \
    && GLIBC_DL_URL="https://github.com/andyshinn/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}" \
    && curl --location --silent --show-error -O ${GLIBC_DL_URL}/glibc-${GLIBC_VERSION}.apk \
    && curl --location --silent --show-error -O ${GLIBC_DL_URL}/glibc-bin-${GLIBC_VERSION}.apk \
    && curl --location --silent --show-error -O ${GLIBC_DL_URL}/glibc-i18n-${GLIBC_VERSION}.apk \
    && apk add --allow-untrusted glibc-${GLIBC_VERSION}.apk \
       glibc-bin-${GLIBC_VERSION}.apk glibc-i18n-${GLIBC_VERSION}.apk \
    && /usr/glibc-compat/sbin/ldconfig /lib /usr/glibc-compat/lib \
    && /usr/glibc-compat/bin/localedef -i en_US -f UTF-8 en_US.UTF-8 \
    && rm -rf glibc-${GLIBC_VERSION}.apk glibc-bin-${GLIBC_VERSION}.apk glibc-i18n-${GLIBC_VERSION}.apk \
    && apk del --purge -r build-dependencies

ENTRYPOINT ["container-structure-test"]
CMD ["--help"]
