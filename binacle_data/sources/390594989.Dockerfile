FROM alpine:3.10 AS builder

RUN apk add --no-cache git make python3 py-virtualenv

ARG GA_ID
ARG GA_CONTENT_GROUP_INDEX
ARG GA_CONTENT_GROUP_NAME

RUN addgroup -S builder && adduser -S -G builder builder

USER builder

COPY --chown=builder:builder . /home/builder/tuleap-documentation

WORKDIR /home/builder/tuleap-documentation

RUN tmp_venv="$(mktemp -d)" && virtualenv "$tmp_venv" && \
    source "$tmp_venv"/bin/activate && \
    pip install -r requirements.txt && \
    make SPHINXOPTS="-D html_theme=tuleap_org -D html_theme_options.ga_id=$GA_ID -D html_theme_options.ga_content_group_index=$GA_CONTENT_GROUP_INDEX -D html_theme_options.ga_content_group_name=$GA_CONTENT_GROUP_NAME" html

FROM nginx:alpine

COPY docs.tuleap.org/nginx.conf /etc/nginx/nginx.conf
COPY --from=builder /home/builder/tuleap-documentation/_build/html/en/ /usr/share/nginx/html
