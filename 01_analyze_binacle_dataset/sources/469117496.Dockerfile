FROM opensuse/tumbleweed:latest

RUN \
  zypper ar --refresh --enable --no-gpgcheck https://download.opensuse.org/repositories/devel:/kubic/openSUSE_Tumbleweed extra-repo0 && \
  zypper ref -r extra-repo0 && \
  zypper in -y --no-recommends cri-tools iptables iproute2 systemd kubernetes-kubeadm && \
  zypper clean -a

# Copy stuff to the image...
# (check the .dockerignore file for exclusions)

# Copy all the static files
ADD config/manifests /usr/lib/kubic/manifests

### TODO: do not build the kubic-init exec IN this container:
###       maybe we will use the OBS and this whole Dockerfile
###       will be gone...
COPY cmd/kubic-init/kubic-init /usr/local/bin/kubic-init
RUN chmod 755 /usr/local/bin/kubic-init*

### Directories we will mount from the host
VOLUME /sys/fs/cgroup

ENV SYSTEMCTL_FORCE_BUS 1
ENV DBUS_SYSTEM_BUS_ADDRESS unix:path=/var/run/dbus/system_bus_socket

CMD ["/usr/local/bin/kubic-init"]
