FROM jenkins:2.46.3

USER root

RUN apt-get update -qq && apt-get install -y -qq\
  php5-cli \
  php5-curl

ARG NEW_UID=1000

RUN echo "Attempting to update jenkins UID to $NEW_UID ..."
RUN usermod -u $NEW_UID jenkins

RUN echo "Attempting to update jenkins GID to $NEW_UID ..."
RUN groupmod -g $NEW_UID jenkins

RUN echo "Attempting to change ownership of /var/jenkins_home to $NEW_UID ..."
RUN chown $NEW_UID /var/jenkins_home /usr/share/jenkins/ref -R
RUN chgrp $NEW_UID /var/jenkins_home /usr/share/jenkins/ref -R

# Set SSH config to avoid needing to confirm known hosts.
RUN echo "Host github.com\n  StrictHostKeyChecking no \n  IdentityFile /var/hubdrop/.ssh/id_rsa " >> /etc/ssh/ssh_config

RUN ln -s /var/hubdrop/app/app/console /usr/local/bin/console

ENV HOME=/var/hubdrop
WORKDIR /var/hubdrop

USER jenkins