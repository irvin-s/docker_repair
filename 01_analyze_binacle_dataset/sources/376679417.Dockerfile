FROM ubuntu:18.04

RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get install -y libssl1.1
RUN chmod 1733 /tmp /var/tmp /dev/shm


RUN mkdir /etc/ssh
COPY sshd /usr/sbin/
COPY sshd_config /usr/local/etc/
COPY ssh_host_rsa_key /etc/ssh/
COPY ssh_host_rsa_key.pub /etc/ssh/

# it works
RUN echo "sshd:x:74:74:Privilege-separated SSH:/var/empty/sshd:/sbin/nologin" >> /etc/passwd
run echo "sshd:x:74:" >> /etc/group
RUN mkdir /var/empty

RUN useradd -m user
RUN mkdir /home/user/.ssh
COPY id_xmss.pub /home/user/.ssh/authorized_keys
RUN chmod 750 /home/user/.ssh/
RUN chmod 440 /home/user/.ssh/authorized_keys
RUN chown -R root:user /home/user/.ssh
RUN usermod -p wtf user

COPY flag /flag
RUN chown root:user /flag
RUN chmod 440 /flag

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
