FROM python:2.7-slim

RUN useradd -m -d /home/ec2-user ec2-user
RUN apt-get update && apt-get install -y curl && apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /tmp/ectou-metadata
ADD . /tmp/ectou-metadata
RUN python ./setup.py install

# Install Tini
RUN curl -L https://github.com/krallin/tini/releases/download/v0.15.0/tini > tini && \
    echo "5e92b8d11dae337be0a929d0f8a737a84cebe35959503e4c42acbe76c4d69190 *tini" | sha256sum -c - && \
    mv tini /usr/local/bin/tini && \
    chmod +x /usr/local/bin/tini

ENV MOCK_METADATA_PORT 5000

EXPOSE ${MOCK_METADATA_PORT}

USER ec2-user

ENTRYPOINT ["tini", "--"]
CMD ectou_metadata --host 0.0.0.0 --port ${MOCK_METADATA_PORT} --role-arn ${MOCK_METADATA_ROLE_ARN}
