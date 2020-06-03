# AWS-CLI v1.16
# docker run --rm supinf/awscli:1.16 --version
# docker run --rm -v $HOME/.aws:/root/.aws supinf/awscli:1.16 sts get-caller-identity

FROM alpine:3.9

ENV PAGER=less \
    LESS="-eirMX"

RUN apk --no-cache add "python3=3.6.8-r2" "less=530-r0" "groff=1.22.3-r2" "jq=1.6-r0" \
    && find / -depth -type d -name __pycache__ -exec rm -rf {} \; \
    && rm -rf /usr/share/terminfo

RUN apk --no-cache add --virtual build-deps py3-pip \
    && pip3 install 'awscli == 1.16.143' \
    && apk del --purge -r build-deps \
    && find / -depth -type d -name __pycache__ -exec rm -rf {} \; \
    && rm -rf /root/.cache /lib/apk/db

ENTRYPOINT ["aws"]
CMD ["help"]
