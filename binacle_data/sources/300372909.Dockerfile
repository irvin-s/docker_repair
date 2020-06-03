#
# Simple alpine-based image that ships OpenVPN kubectl and scripts to generate a
# CA on first start and certificates for your OpenVPN users later on.
#
# It is heavily inspired from John Felten's work, but uses Kubernetes secrets
# instead of volumes to store certs and stuff :)
# https://github.com/jfelten/openvpn-docker
#
FROM alpine:latest
MAINTAINER Étienne Lafarge <etienne.lafarge@gmail.com>

# Add openvpn, easy-rsa and other required packages
RUN apk add --update openvpn openssl easy-rsa openvpn iptables

# Add kubectl binary
ADD https://storage.googleapis.com/kubernetes-release/release/v1.6.4/bin/linux/amd64/kubectl /usr/local/bin/kubectl
RUN chmod +x /usr/local/bin/kubectl

# Set up the environment variables that configure the pod (Kubernetes
# secret names and namespaces)
ENV K8S_SECRET_NAMESPACE default
ENV SERVER_TLS_SECRET openvpn-tls-assets
ENV CLIENT_CERTS_SECRET openvpn-tls-assets

ENV OVPN_PROTO tcp
ENV OVPN_NETWORK 10.240.0.0
ENV OVPN_SUBNET 255.255.255.0
ENV OVPN_PORT 42062
ENV OVPN_K8S_POD_NETWORK 10.1.0.0
ENV OVPN_K8S_POD_SUBNET 255.255.0.0

# Let's make sure we can run ./easyrsa
WORKDIR /etc/openvpn/certs

# Configure tun
RUN mkdir -p /dev/net && \
    mknod /dev/net/tun c 10 200

# Copy our dirty shell scripts
COPY ./entrypoint.sh /kube-openvpn/entrypoint.sh
COPY ./gen_client_cert.sh /kube-openvpn/gen_client_cert.sh
COPY ./openvpn.template.conf /kube-openvpn/openvpn.template.conf
RUN chmod +x /kube-openvpn/*.sh

ENTRYPOINT ["/kube-openvpn/entrypoint.sh"]
