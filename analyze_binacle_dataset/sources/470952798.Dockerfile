FROM alpine:3.7

ENV KUBEVER=1.13.4 \
    HELMVER=2.13.0 \
    HELMDIFFVER="2.11.0%2B3" \
    KUBEVALVER=0.7.3 \
    VAULTVER=0.11.1 \
    HOME=/config \
    SSL_CERT_DIR=/etc/ssl/certs/

# Install shipcat (built for musl outside)
ADD shipcat.x86_64-unknown-linux-musl /usr/local/bin/shipcat

# Install kubectl (see https://aur.archlinux.org/packages/kubectl-bin )
ADD https://storage.googleapis.com/kubernetes-release/release/v${KUBEVER}/bin/linux/amd64/kubectl /usr/local/bin/kubectl

# Install everything
# NB: skipping https://github.com/garethr/kubetest because alpine dylibs fail
RUN set -x && \
    apk update && \
    apk add --no-cache curl ca-certificates make bash jq git python3 unzip && \
    chmod +x /usr/local/bin/kubectl && \
    curl -sSL https://storage.googleapis.com/kubernetes-helm/helm-v${HELMVER}-linux-amd64.tar.gz | tar xz -C /usr/local/bin --strip-components=1 && \
    curl -sSL https://github.com/garethr/kubeval/releases/download/${KUBEVALVER}/kubeval-linux-amd64.tar.gz | tar xvz -C /usr/local/bin && \
    curl -sSL https://releases.hashicorp.com/vault/${VAULTVER}/vault_${VAULTVER}_linux_amd64.zip > vault.zip && \
    unzip vault.zip && mv vault /usr/local/bin && \
    apk del unzip && rm vault.zip && \
    # Create non-root user
    adduser kubectl -Du 1000 -h /config && \
    \
    # Basic check it works.
    kubectl version --client && \
    shipcat --version && \
    helm version -c && \
    kubeval --version

# Setup helm and plugins
# Currently the version pinning mechanism in helm plugin does not work for tags with + in them
# See https://github.com/databus23/helm-diff/issues/50
# Also cannot sanity check installation because it tries to talk to the cluster
RUN set -x && \
    helm init -c && \
    curl -sSL https://github.com/databus23/helm-diff/releases/download/v${HELMDIFFVER}/helm-diff-linux.tgz | tar xvz -C $(helm home)/plugins


# Add core dependencies of validation
RUN apk add --no-cache --virtual virtualbuild libffi-dev g++ python3-dev openssl-dev && \
    pip3 install --upgrade pip && \
    pip3 install yamllint yq && \
    pip3 install semver jira jinja2 && \
    apk del virtualbuild

USER kubectl
