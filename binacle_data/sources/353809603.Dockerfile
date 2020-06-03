FROM rancher/agent-base:v0.3.0
RUN apt-get update && \
    apt-get install -y vim wget bash-completion unzip netcat-openbsd
RUN wget -O /usr/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/v1.7.4/bin/linux/amd64/kubectl && \
    chmod +x /usr/bin/kubectl
RUN wget -O helm.tar.gz http://storage.googleapis.com/kubernetes-helm/helm-v2.3.0-linux-amd64.tar.gz && \
    tar xvzf helm.tar.gz && \
    mv ./linux-amd64/helm /usr/bin/ && \
    chmod +x /usr/bin/helm
ENV SSL_SCRIPT_COMMIT 98660ada3d800f653fc1f105771b5173f9d1a019
RUN wget -O /usr/bin/update-rancher-ssl https://raw.githubusercontent.com/rancher/rancher/${SSL_SCRIPT_COMMIT}/server/bin/update-rancher-ssl && \
    chmod +x /usr/bin/update-rancher-ssl
ENV KUBE_SERVER http://localhost:8080
COPY kubectld kubectld.sh kubectl-shell.sh kubectl-shell-entry.sh shell-setup.sh /usr/bin/
COPY completion/kubectl /etc/bash_completion.d/
ENV SERVER http://localhost:8080
ENV LISTEN :8091
CMD ["kubectld.sh"]
