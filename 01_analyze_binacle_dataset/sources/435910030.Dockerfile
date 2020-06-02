FROM ubuntu:xenial

ENV DEBIAN_FRONTEND noninteractive

# Update
RUN apt-get update --fix-missing && apt-get -y upgrade

# Dependencies
RUN apt-get install -y lib32z1 xinetd
RUN apt-get install -y qemu qemu-user qemu-user-static libc6-mipsel-cross

# CTF user account
RUN groupadd -r ctf && useradd -r -g ctf ctf

# Add Resources
ADD ctf.xinetd /etc/xinetd.d/ctf
ADD chall_init.sh /etc/chall_init.sh
ADD flag /home/ctf/flag
ADD blagult /home/ctf/blagult
ADD chall /home/ctf/chall
ADD redir.sh /home/ctf/redir.sh
ADD lib/libc.so.6 /home/ctf/lib/libc.so.6
ADD lib/ld.so.1 /home/ctf/lib/ld.so.1

# Permissions
RUN chown -R root:ctf /home/ctf
RUN chmod 750 /home/ctf/blagult
RUN chmod 750 /home/ctf/redir.sh
RUN chmod 750 /home/ctf/chall
RUN chmod 700 /etc/chall_init.sh
RUN chmod 440 /home/ctf/flag
RUN chmod 750 /home/ctf/lib/libc.so.6
RUN chmod 750 /home/ctf/lib/ld.so.1