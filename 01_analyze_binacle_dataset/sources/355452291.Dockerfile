FROM rancher/agent-base:v0.3.0
RUN apt-get update -y && \
    apt-get -yy -q install ca-certificates wget unzip
ENV SSL_SCRIPT_COMMIT 98660ada3d800f653fc1f105771b5173f9d1a019
RUN wget -O /usr/bin/update-rancher-ssl https://raw.githubusercontent.com/rancher/rancher/${SSL_SCRIPT_COMMIT}/server/bin/update-rancher-ssl && \
    chmod +x /usr/bin/update-rancher-ssl
COPY ./kubernetes-agent /usr/bin/kubernetes-agent
CMD ["kubernetes-agent"]
