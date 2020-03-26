FROM ubuntu:trusty

MAINTAINER "Toshiki Inami <t-inami@arukas.io>"

# Set username/password login as a default
# public authentication will be enabled with AUTHORIZED_KEY ENV
ENV ROOT_PWD default
ENV AUTHORIZED_KEY none

# Install openssh-server, and then clean up
RUN apt-get update && apt-get install -y \
      openssh-server \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/run/sshd

# Make start.sh excutable
COPY start.sh /start.sh

# Configure sshd.conf
## For username/password login
RUN sed -i "s/PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config

# Expose 22 for SSH access
EXPOSE 22

# Start supervisord to controll processes
CMD ["./start.sh", "-bash"]
