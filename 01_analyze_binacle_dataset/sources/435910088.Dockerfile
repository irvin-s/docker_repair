FROM ubuntu:xenial

ENV DEBIAN_FRONTEND noninteractive

# Update
RUN apt-get update --fix-missing && apt-get -y upgrade

# Dependencies
RUN apt-get install -y lib32z1 xinetd
RUN apt-get install -y qemu

# CTF user account
RUN groupadd -r ctf && useradd -r -g ctf ctf

# Add Resources
ADD ctf.xinetd /etc/xinetd.d/ctf
ADD chall_init.sh /etc/chall_init.sh
ADD redir.sh /home/ctf/redir.sh
ADD kernel /home/ctf/kernel
ADD initrd /home/ctf/initrd
ADD run.sh /home/ctf/run.sh

# Permissions
RUN chown -R root:ctf /home/ctf
RUN chmod 750 /home/ctf/redir.sh
RUN chmod 700 /etc/chall_init.sh
RUN chmod 750 /home/ctf/run.sh
