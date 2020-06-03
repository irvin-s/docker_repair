FROM fedora:25

RUN dnf install -y \
  ansible \
  genisoimage \
  openssh-clients \
  python2-avocado \
  qemu-system-x86

COPY avocado.conf /etc/avocado

VOLUME /system-api-test /cache

RUN useradd -m tester
USER tester

# NOTE can be removed once avocado handles its cache configuration correctly
RUN mkdir -p /home/tester/avocado/data/cache

WORKDIR /system-api-test
