FROM ubuntu
LABEL maintainer="docker@carlosbecker.com"
ENTRYPOINT ["/usr/local/bin/shcheck"]
CMD [ "-h" ]

RUN apt-get update && apt-get install -y ca-certificates && rm -rf /var/lib/apt/lists/*

COPY shcheck /usr/local/bin/shcheck
