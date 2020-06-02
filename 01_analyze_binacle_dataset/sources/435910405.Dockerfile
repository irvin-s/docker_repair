FROM ubuntu:latest

ENV DEBIAN_FRONTEND noninteractive

#update
RUN apt-get update --fix-missing && apt-get -y upgrade

#system deps
RUN apt-get install -y lib32z1 xinetd python

#create ctf-user
RUN groupadd -r ctf && useradd -r -g ctf ctf

#add chall items
ADD ctf.xinetd /etc/xinetd.d/ctf
ADD chall_init.sh /etc/chall_init.sh
ADD chall /home/ctf/chall
ADD redir.sh /home/ctf/redir.sh
ADD flag.py /home/ctf/flag.py

#set some proper permissions
RUN chown -R root:ctf /home/ctf
RUN chmod 750 /home/ctf/chall
RUN chmod 750 /home/ctf/redir.sh
RUN chmod 750 /home/ctf/flag.py
RUN chmod 700 /etc/chall_init.sh

RUN service xinetd restart
