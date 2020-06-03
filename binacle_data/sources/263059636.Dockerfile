FROM alpine:3.8
LABEL MAINTAINER=olly@docker.com

ARG UCPURL="https://ucp.olly.dtcntr.net:8443"
ARG KUBEVER="1.11.2"

RUN apk add --upgrade --no-cache \
    ca-certificates \
    curl \
    git \
    wget && \
    rm -rf /var/cache/apk/*

# Embed UCP CA Certificate
RUN (curl -sk ${UCPURL}/ca > /usr/local/share/ca-certificates/ca.crt && \
    update-ca-certificates)

# Install the Docker Client
RUN (wget -q --no-check-certificate ${UCPURL}/linux/docker && \
  mv docker /usr/local/bin/docker && \
  chmod +x /usr/local/bin/docker)

# Install the Kubectl Client
RUN (curl -LO https://storage.googleapis.com/kubernetes-release/release/v${KUBEVER}/bin/linux/amd64/kubectl && \
   mv kubectl /usr/local/bin/kubectl && \
   chmod +x /usr/local/bin/kubectl)

CMD ["sh", "-c", "tail -f /dev/null"]
