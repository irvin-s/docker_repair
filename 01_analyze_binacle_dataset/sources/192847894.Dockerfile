#
# Nginx image with Consul Template
#
FROM nginx:1.13
MAINTAINER 1science Devops Team <devops@1science.org>

RUN apt-get update && apt-get install -y curl unzip less vim

# Consul template for configuration management
ENV S6_OVERLAY_VERSION=1.19.1.1 CONSUL_TEMPLATE_VERSION=0.18.2

# Install S6 Overlay and Consul Template
RUN curl -Ls https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-amd64.tar.gz | tar -xz -C /
RUN curl -Ls https://releases.hashicorp.com/consul-template/${CONSUL_TEMPLATE_VERSION}/consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip -o consul-template.zip && \
    unzip consul-template.zip -d /usr/local/bin && \
    rm -f consul-template* && \
    echo -ne "- with `consul-template -v 2>&1`\n" >> /root/.built

# Add services configuration
ADD etc /etc

ENTRYPOINT ["/init"]
CMD ["nginx", "-g", "daemon off;"]