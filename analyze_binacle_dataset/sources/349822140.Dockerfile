# Base image: Ubuntu 14.04
FROM ubuntu:14.04

# Make sure things are up to date
RUN sudo apt-get update; sudo apt-get install -y curl gnupg python ruby build-essential;

# Install some build tools we'll need for more specific images
# in this chain.
RUN sudo apt-get update && sudo apt-get install -y git build-essential

# Set up a non-privileged user to run them.
USER root
RUN mkdir /home/swuser
RUN groupadd -r swuser -g 433 && \
useradd -u 431 -r -g swuser -d /home/swuser -s /sbin/nologin \
-c "Docker image user" swuser && \
chown -R swuser:swuser /home/swuser
