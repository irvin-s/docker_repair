FROM ubuntu:xenial

RUN apt update && apt upgrade -y
RUN apt install -y xinetd

RUN adduser easy_calc
COPY flag1.txt /home/easy_calc/
COPY flag2.txt /home/easy_calc/
COPY run.sh /home/easy_calc/
COPY easy_calc /home/easy_calc/

COPY pwn /etc/xinetd.d/
RUN echo "pwn 8000/tcp" >> /etc/services 
EXPOSE 8000

CMD /usr/sbin/xinetd -dontfork
