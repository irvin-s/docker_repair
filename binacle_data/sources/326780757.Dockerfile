FROM python:3.7-rc-alpine

# metadata injected at build time
ARG BUILD_DATE
ARG VCS_REF
ARG VERSION

LABEL org.label-schema.build-date=$BUILD_DATE \
        org.label-schema.name="Open Source Chaos Hub" \
        org.label-schema.description="Open Source Chaos Hub" \
        org.label-schema.url="https://chaoshub.org" \
        org.label-schema.vcs-ref=$VCS_REF \
        org.label-schema.vcs-url="https://github.com/chaostoolkit/chaoshub" \
        org.label-schema.vendor="ChaosIQ, Ltd" \
        org.label-schema.version=$VERSION \
        org.label-schema.schema-version="1.0"


VOLUME ["/var/chaoshub"]

ADD app/requirements.txt requirements.txt
RUN apk update && \
    apk add --virtual build-deps gcc g++ git libffi-dev linux-headers \
        python3-dev musl-dev && \
    apk add libstdc++ postgresql-dev && \
    pip install -U pip && \
    pip install --no-cache-dir -r requirements.txt && \
    apk del build-deps && \
    rm -rf /tmp/* /root/.cache && \
    mkdir /etc/chaoshub && mkdir ui

ADD LICENSE.txt /etc/chaoshub/LICENSE.txt
ADD app/. .
ADD ui/dist ui/dist
ADD app/.env.sample /etc/chaoshub/.env
RUN python3 setup.py install && \
    rm -rf build dist .cache *.egg-info

EXPOSE 8080/tcp

ENTRYPOINT ["chaoshub-dashboard"]
CMD ["run", "--env-path", "/etc/chaoshub", "--create-tables"]