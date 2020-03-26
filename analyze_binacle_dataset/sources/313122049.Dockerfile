FROM fedora:27
RUN dnf install -y dhclient
COPY cmd/sidecar/assign-addresses /bin/assign-addresses
ENTRYPOINT ["/bin/assign-addresses"]
