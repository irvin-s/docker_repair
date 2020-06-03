FROM ubuntu:latest
RUN apt-get update
RUN apt-get install -y xinetd
RUN apt-get install -y libc6-i386
RUN useradd -m boverflow
COPY ./boverflow /home/boverflow/boverflow
COPY ./flag.txt /home/boverflow/flag.txt
COPY ./boverflowservice /etc/xinetd.d/boverflowservice
RUN chown -R root:boverflow /home/boverflow
RUN chmod -R 750 /home/boverflow
RUN chown root:boverflow /home/boverflow/flag.txt
RUN chmod 440 /home/boverflow/flag.txt
EXPOSE 31337
CMD ["/usr/sbin/xinetd", "-d"]
