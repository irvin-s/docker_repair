FROM debian:stable
MAINTAINER Tom Parys "tom.parys+copyright@gmail.com"

# Tell debconf to run in non-interactive mode
ENV DEBIAN_FRONTEND noninteractive

# Setup multiarch because Skype is 32bit only
RUN dpkg --add-architecture i386

# Make sure the repository information is up to date
RUN apt-get update


# Install PulseAudio for i386 (64bit version does not work with Skype)
RUN apt-get install -y libpulse0:i386 pulseaudio:i386

# We need ssh to access the docker container, wget to download skype
RUN apt-get install -y openssh-server wget 

# Install Skype
RUN wget http://download.skype.com/linux/skype-debian_4.3.0.37-1_i386.deb -O /usr/src/skype.deb
RUN dpkg -i /usr/src/skype.deb || true
RUN apt-get install -fy						# Automatically detect and install dependencies


# Create user "docker" and set the password to "docker"
RUN useradd -m -d /home/docker docker
RUN echo "docker:docker" | chpasswd

# Create OpenSSH privilege separation directory, enable X11Forwarding
RUN mkdir -p /var/run/sshd
RUN echo X11Forwarding yes >> /etc/ssh/ssh_config

# Prepare ssh config folder so we can upload SSH public key later
RUN mkdir /home/docker/.ssh
RUN chown -R docker:docker /home/docker
RUN chown -R docker:docker /home/docker/.ssh

# Set locale (fix locale warnings)
RUN localedef -v -c -i en_US -f UTF-8 en_US.UTF-8 || true
RUN echo "Europe/Prague" > /etc/timezone

# Set up the launch wrapper - sets up PulseAudio to work correctly
RUN echo 'export PULSE_SERVER="tcp:localhost:64713"' >> /usr/local/bin/skype-pulseaudio
RUN echo 'PULSE_LATENCY_MSEC=60 skype' >> /usr/local/bin/skype-pulseaudio
RUN chmod 755 /usr/local/bin/skype-pulseaudio


# Expose the SSH port
EXPOSE 22

# Start SSH
ENTRYPOINT ["/usr/sbin/sshd",  "-D"]
