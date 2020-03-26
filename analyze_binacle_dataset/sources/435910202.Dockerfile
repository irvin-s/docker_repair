FROM ubuntu:latest

ENV DEBIAN_FRONTEND noninteractive

#update
RUN apt-get update --fix-missing && apt-get -y upgrade
RUN apt-get update --fix-missing 

#system deps
RUN apt-get install -y lib32z1 libseccomp-dev xinetd libcapstone-dev python-pip
RUN pip install capstone
RUN apt-get install -y libglib2.0-dev

#create ctf-user
RUN groupadd -r ctf && useradd -r -g ctf ctf
RUN groupadd -r ctf0 && useradd -r -g ctf0 ctf0
RUN groupadd -r ctf1 && useradd -r -g ctf1 ctf1
RUN groupadd -r ctf2 && useradd -r -g ctf2 ctf2

RUN ln -s /usr/lib/libcapstone.so.3 /usr/lib/libcapstone.so.4
RUN ldconfig

#add chall items
ADD ctf.xinetd /etc/xinetd.d/ctf
ADD chall_init.sh /etc/chall_init.sh

ADD flag0 /home/ctf0/flag
ADD flag1 /home/ctf1/flag
ADD flag2 /home/ctf2/flag

ADD chall /home/ctf0/chall
ADD chall-arm /home/ctf1/chall
ADD chall-mips /home/ctf2/chall

ADD qemu-arm /home/ctf1/qemu
ADD qemu-mips /home/ctf2/qemu

ADD redir0.sh /home/ctf0/redir.sh
ADD redir1.sh /home/ctf1/redir.sh
ADD redir2.sh /home/ctf2/redir.sh

#set some proper permissions
RUN chown -R root:ctf0 /home/ctf0
RUN chmod 750 /home/ctf0/chall
RUN chmod 750 /home/ctf0/redir.sh
RUN chmod 440 /home/ctf0/flag

RUN chown -R root:ctf1 /home/ctf1
RUN chmod 750 /home/ctf1/chall
RUN chmod 750 /home/ctf1/redir.sh
RUN chmod 750 /home/ctf1/qemu
RUN chmod 440 /home/ctf1/flag

RUN chown -R root:ctf2 /home/ctf2
RUN chmod 750 /home/ctf2/chall
RUN chmod 750 /home/ctf2/redir.sh
RUN chmod 750 /home/ctf1/qemu
RUN chmod 440 /home/ctf2/flag

RUN chmod 700 /etc/chall_init.sh

RUN service xinetd restart