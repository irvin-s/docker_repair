FROM ubuntu

ARG _user="skaji"
ARG _authorized_keys="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC6m3sDBs55bGiyb35idIRx7NWGVl0P9zh9SZniclZFeYRqtlknpOBQ3H6jUeOORSCqrOYqmg2/e/2FDFr2BfhSnYnI45BqBKEgxs8YMkrqKLv6x9ntA9foiW01NZV+8dNsarSSxyGAX/+huLfITe48fPvZHp4QxpcvC6Xtmx6MQJoUZNWIoPLjslOJzHbKj8V85kkE3kXfYs5Grz7K3nbXM7jFy+2A461VL6ARYscHmSR5Xmj+6Yvc6w2UWmGv7+ilyrtwDYPs5Sh56T1zKCr9tNEIGZYJW/tIOgUthgt2rrfpt2Yk5B6LSeTcj1tilQ+1BZ8IXZic16SNuzYVLYZV skaji@MBP2013.local"

RUN export DEBIAN_FRONTEND=noninteractive \
  && apt-get update -y \
  && apt-get install -y \
    openssh-server \
    locales-all \
    sudo \
  && apt-get autoremove -y \
  && apt-get clean -y \
  && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

RUN useradd -m -s /bin/bash $_user \
  && echo "$_user:$_user" | chpasswd \
  && echo "$_user ALL=(ALL) ALL" > /etc/sudoers.d/$_user \
  && install -d -g $_user -o $_user -m 700 /home/$_user/.ssh \
  && echo "$_authorized_keys" > /home/$_user/.ssh/authorized_keys \
  && chown $_user:$_user /home/$_user/.ssh/authorized_keys \
  && chmod 400 /home/$_user/.ssh/authorized_keys

RUN install -d -m 0755 /run/sshd

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
