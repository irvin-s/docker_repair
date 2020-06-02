# This file creates a container that runs X11 and SSH services
# The ssh is used to forward X11 and provide you encrypted data
# communication between the docker container and your local 
# machine.
#
# Xpra allows to display the programs running inside of the
# container such as Firefox, LibreOffice, xterm, etc. 
# with disconnection and reconnection capabilities
#
# Xephyr allows to display the programs running inside of the
# container such as Firefox, LibreOffice, xterm, etc. 
#
# Fluxbox and ROX-Filer creates a very minimalist way to 
# manages the windows and files.
#
# Author: Roberto Gandolfo Hashioka
# Date: 07/28/2013


FROM silarsis/base
MAINTAINER Kevin Littlejohn <kevin@littlejohn.id.au>

# Winswitch, experimental
RUN apt-get -yq install curl && curl http://winswitch.org/gpg.asc | apt-key add -
RUN echo "deb http://winswitch.org/ quantal main" > /etc/apt/sources.list.d/winswitch.list

# Installing the required environment
RUN apt-get install -y xpra rox-filer ssh xserver-xephyr xdm fluxbox firefox xterm winswitch

# Configuring xdm to allow connections from any IP address and ssh to allow X11 Forwarding. 
RUN sed -i 's/DisplayManager.requestPort/!DisplayManager.requestPort/g' /etc/X11/xdm/xdm-config
RUN sed -i '/#any host/c\*' /etc/X11/xdm/Xaccess
RUN ln -s /usr/bin/Xorg /usr/bin/X
RUN echo X11Forwarding yes >> /etc/ssh/ssh_config
RUN sed 's/session    required     pam_loginuid.so/session optional pam_loginuid.so/' -i /etc/pam.d/sshd 

# Set locale (fix the locale warnings)
RUN localedef -v -c -i en_US -f UTF-8 en_US.UTF-8 || :

# Copy the files into the container
ADD . /src

# Add the local user
RUN adduser --disabled-password --gecos "" silarsis \
  && echo "silarsis ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers \
  && echo 'silarsis:passwd' | chpasswd
RUN mkdir -p /var/run/sshd
RUN cd /src/config/ && sudo -u silarsis cp -R .[a-z]* [a-z]* /home/silarsis/

EXPOSE 22
# Start xdm and ssh services.
CMD ["/bin/bash", "/src/startup.sh"]
