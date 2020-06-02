FROM jenkins:2.32.1-alpine
USER root

# install plugins
RUN /usr/local/bin/install-plugins.sh kubernetes:0.10