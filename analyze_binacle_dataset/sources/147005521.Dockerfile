FROM ubuntu:xenial

RUN apt update && apt upgrade -y
RUN apt install -y xinetd

RUN adduser hard_rop
COPY flag1.txt /home/hard_rop/
COPY flag2.txt /home/hard_rop/
COPY run.sh /home/hard_rop/
COPY hard_rop /home/hard_rop/

COPY pwn /etc/xinetd.d/
RUN echo "pwn 8000/tcp" >> /etc/services 
EXPOSE 8000

CMD /usr/sbin/xinetd -dontfork
