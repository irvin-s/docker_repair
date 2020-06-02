#
# Dockerfile - Build and Setup Busbar Container
#

# Base Image
FROM ruby:2.3.1-onbuild

# Add kubectl
ADD https://storage.googleapis.com/kubernetes-release/release/v1.9.6/bin/linux/amd64/kubectl /usr/bin/kubectl
RUN chmod a+x /usr/bin/kubectl

# Add docker
RUN wget https://get.docker.com/builds/Linux/x86_64/docker-1.13.1.tgz -O /tmp/docker.tgz
RUN tar xf /tmp/docker.tgz -C /usr/bin --strip-components=1 && rm -f /tmp/docker.tgz

# Update git client
RUN echo "deb http://ftp.us.debian.org/debian testing main contrib non-free" >> /etc/apt/sources.list \
    &&      apt-get update              \
    &&      apt-get remove  -y binutils \
    &&      apt-get install -y git      \
    &&      apt-get clean all

# Add Github and Bitbucket keys
RUN mkdir /root/.ssh && chmod 0700 /root/.ssh
RUN ssh-keyscan -t rsa github.com >> /root/.ssh/known_hosts
RUN ssh-keyscan -t rsa bitbucket.org >> /root/.ssh/known_hosts

# Remove pem key created during development
RUN rm config/deploy.pem
