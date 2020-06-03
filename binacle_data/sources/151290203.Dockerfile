FROM silarsis/base
MAINTAINER Kevin Littlejohn <kevin@littlejohn.id.au>

RUN apt-get -yq install openssh-server; \
  mkdir -p /var/run/sshd; \
  mkdir /root/.ssh && chmod 700 /root/.ssh
# Add our ssh key
ADD id_rsa.pub /root/.ssh/authorized_keys
RUN chmod 400 /root/.ssh/authorized_keys && chown root. /root/.ssh/authorized_keys
# Fix the locale
RUN locale-gen en_US en_US.UTF-8 && dpkg-reconfigure locales
# Fix the requirement for audit capabilities in ssh login
RUN sed 's/session    required     pam_loginuid.so/session optional pam_loginuid.so/' -i /etc/pam.d/sshd
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
