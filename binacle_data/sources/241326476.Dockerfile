# textlint with reStructuredText support
# docker run --rm -it -v $(pwd):/work supinf/textlint:11.2-rst

FROM supinf/textlint:11.2

RUN yarn global add "textlint-plugin-rst@0.1.1" \
    && rm -rf /usr/local/share/.cache

RUN apk --no-cache add python3 \
    && pip3 install docutils-ast-writer \
    && find / -depth -type d -name __pycache__ -exec rm -rf {} \; \
    && rm -rf /root/.cache

COPY textlint.conf.json /
