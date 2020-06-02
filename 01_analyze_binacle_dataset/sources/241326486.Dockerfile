# CFn-Lint v0.19
# docker run --rm supinf/cfn-lint:0.19
# docker run --rm -v "$(pwd)":/work supinf/cfn-lint:0.19 **/*.yaml

FROM alpine:3.9

RUN apk --no-cache add python py-setuptools
RUN apk --no-cache add --virtual build-deps py-pip \
    && pip install 'cfn-lint==0.19.0' \
    && apk del --purge -r build-deps

WORKDIR /work

ENTRYPOINT ["cfn-lint"]
CMD ["--help"]
