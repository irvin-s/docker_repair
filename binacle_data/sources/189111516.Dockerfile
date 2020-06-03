#
# Ubuntu Dockerfile
#
# https://github.com/dockerfile/ubuntu
#

# Pull base image.
FROM rounds/10m-base

WORKDIR /opt

# Install.
RUN \
  cd /opt && \ 
  wget -q https://download.elastic.co/kibana/kibana/kibana-4.1.2-linux-x64.tar.gz && \
  tar xvfz kibana-*.tar.gz && \
  rm kibana-*.tar.gz

EXPOSE 5601

# Define default command.
CMD cd kibana*/bin && ./kibana
