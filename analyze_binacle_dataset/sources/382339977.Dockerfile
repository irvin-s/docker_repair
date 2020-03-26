# kubeadm (for pre-generating cluster tokens)
FROM ubuntu:latest as kubeadm
RUN apt-get update
RUN apt-get install -y curl
RUN curl -sSL https://dl.k8s.io/release/v1.11.3/bin/linux/amd64/kubeadm > /usr/bin/kubeadm
RUN chmod a+rx /usr/bin/kubeadm

ENTRYPOINT ["/usr/bin/kubeadm"]