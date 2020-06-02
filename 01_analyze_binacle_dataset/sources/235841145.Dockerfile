FROM debian:stretch
RUN apt-get update -y

# Install Ansible
RUN apt-get install --no-install-recommends -y -q build-essential ca-certificates python-pip python-dev python-yaml libffi-dev libssl-dev libxml2-dev libxslt1-dev zlib1g-dev git ansible apt-utils systemd
RUN rm -rf /var/lib/apt/lists/* \
    && rm -Rf /usr/share/doc \
    && rm -Rf /usr/share/man \
    && apt-get clean

# Install Ansible inventory file
RUN mkdir -pv /etc/ansible
RUN touch /etc/ansible/hosts
RUN echo "[local]\nlocalhost ansible_connection=local" > /etc/ansible/hosts
