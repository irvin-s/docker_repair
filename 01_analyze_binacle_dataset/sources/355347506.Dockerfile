#
# A Docker image for running neuronal network simulations
#
# This image extends the basic "simulation" image by adding support
# for SSH access and Xwindows.
#

FROM neuralensemble/simulation
MAINTAINER andrew.davison@unic.cnrs-gif.fr

USER root

RUN apt-get update; apt-get install -y openssh-server libx11-dev libxext-dev x11-apps
RUN mkdir /var/run/sshd
EXPOSE 22
ENV KEYFILE=/home/docker/.ssh/id_rsa
RUN mkdir /home/docker/.ssh; chown docker /home/docker/.ssh
RUN /usr/bin/ssh-keygen -q -t rsa -N "" -f $KEYFILE; cat $KEYFILE.pub >> /home/docker/.ssh/authorized_keys
RUN echo "IdentityFile ~/.ssh/id_rsa" >> /etc/ssh/ssh_config
RUN touch /home/docker/.Xauthority; chown docker /home/docker/.Xauthority
CMD ["/usr/sbin/sshd", "-D"]
