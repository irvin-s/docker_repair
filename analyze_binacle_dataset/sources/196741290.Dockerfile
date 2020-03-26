FROM alpine:3.7

RUN apk add openssh --no-cache

RUN adduser -D alice && (echo alice:alice | chpasswd)
COPY id_ecdsa id_ecdsa.pub id_ed25519 id_ed25519.pub /home/alice/.ssh/
RUN cat /home/alice/.ssh/id_ecdsa.pub /home/alice/.ssh/id_ed25519.pub > /home/alice/.ssh/authorized_keys
COPY ssh_host_ecdsa_key ssh_host_ecdsa_key.pub ssh_host_ed25519_key ssh_host_ed25519_key.pub /etc/ssh/
RUN chmod 600 /home/alice/.ssh/* \
  && chmod 700 /home/alice/.ssh \
  && chown -R alice:alice /home/alice \
  && chmod 600 /etc/ssh/ssh_host_*_key \
  && chmod 644 /etc/ssh/ssh_host_*_key.pub
COPY sshd_config /etc/ssh/sshd_config

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D", "-e"]
