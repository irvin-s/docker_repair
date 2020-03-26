FROM ubuntu

RUN apt-get update && apt-get -y upgrade

RUN apt-get install -y xinetd python python-pip netcat
RUN pip install hexdump

#create ctf-user
RUN groupadd -r ctf && useradd -r -g ctf ctf

ADD ctf.xinetd /etc/xinetd.d/ctf
ADD chal.py /home/ctf/chal.py
ADD flag /home/ctf/flag
ADD banner.txt /home/ctf/banner.txt

#set some proper permissions
RUN chown -R root:ctf /home/ctf
RUN chmod 750 /home/ctf/*

EXPOSE 9000
CMD /usr/sbin/xinetd -dontfork
