FROM ubuntu:xenial

RUN apt update && apt upgrade -y
RUN apt install -y xinetd

RUN adduser gsh_v2
COPY flag2.txt /home/gsh_v2/
COPY run.sh /home/gsh_v2/
COPY gsh_v2 /home/gsh_v2/

COPY pwn /etc/xinetd.d/
RUN echo "pwn 8000/tcp" >> /etc/services 
EXPOSE 8000

CMD /usr/sbin/xinetd -dontfork
