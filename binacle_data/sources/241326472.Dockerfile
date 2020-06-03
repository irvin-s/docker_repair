# textlint
# docker run --rm -it supinf/textlint:11.2 -h
# docker run --rm -it -v $(pwd):/work supinf/textlint:11.2

FROM node:10.15.3-alpine

ENV TEXTLINT_VERSION=11.2.5

RUN yarn global add "textlint@${TEXTLINT_VERSION}" \
    && yarn global add "textlint-rule-common-misspellings@1.0.1" \
    && rm -rf /usr/local/share/.cache \
              /usr/local/lib/node_modules/npm/changelogs

WORKDIR /work
COPY textlint.conf.json /

ENTRYPOINT ["textlint"]
CMD ["-c", "/textlint.conf.json", "-f", "pretty-error", "."]
