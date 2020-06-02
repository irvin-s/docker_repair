# textlint with Japanese support
# docker run --rm -it -v $(pwd):/work supinf/textlint:11.2-jp

FROM supinf/textlint:11.2

RUN yarn global add "textlint-rule-preset-ja-technical-writing@3.1.2" \
    && yarn global add "textlint-rule-spellcheck-tech-word@5.0.0" \
    && yarn global add "textlint-rule-no-dead-link@4.4.1" \
    && rm -rf /usr/local/share/.cache

COPY textlint.conf.json /
