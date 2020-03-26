FROM rafaelsoares/archlinux:latest
MAINTAINER Rafael Soares

# Install base-devel
RUN pacman -S --needed --noprogressbar --noconfirm base-devel git; pacman -Scc --noprogressbar --noconfirm

# Create an unprivileged user; grant user guest sudo rights
RUN useradd -m guest && echo 'guest ALL=(ALL) NOPASSWD: /usr/bin/pacman' > /etc/sudoers.d/00-allowed

# Change to an unprivileged user
USER guest

# Install pacaur
COPY inst_pacaur.sh /home/guest/inst_pacaur.sh
RUN sh -x ./home/guest/inst_pacaur.sh && rm /home/guest/inst_pacaur.sh
