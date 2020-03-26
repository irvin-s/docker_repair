FROM bitnami/minideb

RUN install_packages wget curl ca-certificates git
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
RUN chmod +x ./kubectl
RUN mv ./kubectl /usr/bin/kubectl

CMD ["kubectl", "proxy", "--port", "8080"]
