FROM ubuntu:xenial

RUN apt update && apt upgrade -y
RUN apt install -y xinetd

RUN adduser bank_robber
COPY flag.txt /home/bank_robber/
COPY run.sh /home/bank_robber/
COPY bank_robber /home/bank_robber/

COPY pwn /etc/xinetd.d/
RUN echo "pwn 8000/tcp" >> /etc/services 
EXPOSE 8000

CMD /usr/sbin/xinetd -dontfork
