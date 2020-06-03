# Haskell Dockerfile Linter v1.16
# @see https://github.com/hadolint/hadolint
#
# docker run --rm -v $(pwd):/work supinf/hadolint:1.16
# docker run --rm -v $(pwd):/work -e DOCKERFILE_NAME=Dockerfile.prod supinf/hadolint:1.16

FROM alpine:3.9

ENV HADOLINT_VERSION='v1.16.3' \
    DOCKERFILE_NAME='Dockerfile'

RUN apk --no-cache --virtual=build-deps add curl bash \
    && curl --location --silent -o /usr/bin/hadolint \
       "https://github.com/hadolint/hadolint/releases/download/${HADOLINT_VERSION}/hadolint-Linux-x86_64" \
    && chmod +x /usr/bin/hadolint \
    && apk del --purge -r build-deps

WORKDIR /work

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
