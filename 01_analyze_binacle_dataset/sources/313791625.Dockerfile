FROM alpine:3.5

# Set timezone. This is required for correct timestamps
RUN apk add --update --no-cache tzdata ca-certificates && update-ca-certificates
ENV TZ=America/Chicago
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apk add --update --no-cache python3 \
    python3-dev \
    git

COPY collector/. /
RUN pip3 install -r /requirements.txt

# Drop privileges
RUN adduser -D -u 49999 -s /usr/sbin/nologin user
USER 49999

ENTRYPOINT [ "python3", "-u", "/collector.py" ]

