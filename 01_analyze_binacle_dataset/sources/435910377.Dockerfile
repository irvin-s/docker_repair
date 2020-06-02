FROM ubuntu:latest

ENV DEBIAN_FRONTEND noninteractive

# Update
RUN apt-get update --fix-missing && apt-get -y upgrade

# Dependencies
RUN apt-get install -y lib32z1 libseccomp-dev xinetd qemu-system-arm

# CTF user account
RUN groupadd -r ctf && useradd -r -g ctf ctf

# Add Resources
ADD ctf.xinetd /etc/xinetd.d/ctf
ADD chall_init.sh /etc/chall_init.sh
ADD chall /home/ctf/chall
ADD rootfs.img.gz /home/ctf/rootfs.img.gz
ADD zImage /home/ctf/zImage
ADD redir.sh /home/ctf/redir.sh

# Permissions
RUN chown -R root:ctf /home/ctf
RUN chmod 750 /home/ctf/chall
RUN chmod 750 /home/ctf/redir.sh
RUN chmod 444 /home/ctf/rootfs.img.gz
RUN chmod 750 /home/ctf/zImage
RUN chmod 700 /etc/chall_init.sh
