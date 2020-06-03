FROM 32bit/ubuntu:16.04

RUN apt update
RUN apt install -y xinetd

RUN adduser gsh_v1
COPY flag1.txt /home/gsh_v1/
COPY flag2.txt /home/gsh_v1/
COPY run.sh /home/gsh_v1/
COPY gsh_v1 /home/gsh_v1/

COPY pwn /etc/xinetd.d/
RUN echo "pwn 8000/tcp" >> /etc/services 
EXPOSE 8000

CMD /usr/sbin/xinetd -dontfork
