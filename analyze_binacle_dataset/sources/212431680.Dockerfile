FROM ubuntu:latest
RUN apt-get update
RUN apt-get install -y xinetd
RUN useradd -m sanitypwn
COPY ./flag.txt /home/sanitypwn/flag.txt
COPY ./sanity-pwn.py /home/sanitypwn/sanity-pwn.py
COPY ./pwn.sh /home/sanitypwn/pwn.sh
COPY ./sanitypwnx /etc/xinetd.d/sanitypwnx
RUN chmod 400 /home/sanitypwn/flag.txt
RUN chmod 700 /home/sanitypwn/sanity-pwn.py
RUN chmod 700 /home/sanitypwn/pwn.sh
RUN chown sanitypwn:sanitypwn /home/sanitypwn/*
EXPOSE 1337
CMD ["/usr/sbin/xinetd", "-d"]
