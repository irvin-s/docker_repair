FROM ubuntu:16.04

# Base Docker for unpriviledge SSH
RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN mkdir /home/challenge/
RUN useradd -d /home/challenge/ -s /bin/bash challenge
RUN echo 'challenge:password' | chpasswd
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile
RUN echo "AllowUsers challenge" >> /etc/ssh/sshd_config

# Target victim of the challenge
RUN useradd admin
RUN apt-get update && apt-get install -y sudo strace ltrace gdb

# Faulty permission
RUN mkdir /home/admin/
RUN echo "FLAG-d0b82ec683f845f7b4d74fec13212224" >> /home/admin/flag.txt
RUN chmod 640 /home/admin/flag.txt
RUN chown root:admin /home/admin/flag.txt

COPY data/challenge /home/admin/challenge
COPY data/challenge.c /home/admin/challenge.c

RUN chown root:root /home/admin/challenge.c
RUN chown root:root /home/admin/challenge

RUN echo "challenge ALL=(admin) NOPASSWD: /home/admin/challenge" >> /etc/sudoers

RUN rm /etc/update-motd.d/00-header
RUN rm /etc/update-motd.d/10-help-text
RUN echo 'Welcome to the exploit box. Use the following command to start the challenge : sudo -u admin /home/admin/challenge' > /etc/legal
RUN echo '' > /run/motd.dynamic

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
