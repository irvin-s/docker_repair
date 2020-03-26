FROM ubuntu:xenial

RUN apt update && apt upgrade -y
RUN apt install -y xinetd

RUN adduser bof_study
COPY flag1.txt /home/bof_study/
COPY flag2.txt /home/bof_study/
COPY run.sh /home/bof_study/
COPY bof_study /home/bof_study/

COPY pwn /etc/xinetd.d/
RUN echo "pwn 8000/tcp" >> /etc/services 
EXPOSE 8000

CMD /usr/sbin/xinetd -dontfork
