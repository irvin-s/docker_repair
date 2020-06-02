FROM ubuntu:18.04
ENV PATH="${PATH}:/usr/local/go/bin:/usr/local/kubebuilder/bin"
COPY install-deps.sh install-deps.sh
RUN ./install-deps.sh
