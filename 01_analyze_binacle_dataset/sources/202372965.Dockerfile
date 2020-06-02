FROM debian:jessie

ENV CERT_RENEW_VERSION=v0.0.4

RUN apt-get update \
    && apt-get install -y \
                        curl \
                        wget \
                        openssh-client \
                        cron \
                        bc \
                        jq \
    && rm -rf /var/lib/apt/lists/*

# setup letsencrypt bot
RUN wget https://dl.eff.org/certbot-auto && chmod a+x ./certbot-auto
RUN echo "y" | DEBIAN_FRONTEND=noninteractive ./certbot-auto; exit 0 && \
        ln -s /root/.local/share/cert-bot/bin/cert-bot /usr/local/bin/cert-bot && \
        rm -rf /etc/letsencrypt

RUN echo "Cert-Renew $CERT_RENEW_VERSION" > /root/.built && cat /root/.built

# Pull down kubectl
ENV KUBERNETES_VERSION=1.7.0
RUN curl -s -o /usr/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/v$KUBERNETES_VERSION/bin/linux/amd64/kubectl && chmod +x /usr/bin/kubectl

WORKDIR /cert-renew

CMD ["/bin/bash"]
