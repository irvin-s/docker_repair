FROM ubuntu:latest
RUN apt-get update
RUN useradd -m heapsim
COPY ./simulator2002 /home/heapsim/simulator2002
RUN chmod 700 /home/heapsim/simulator2002
RUN chown heapsim:heapsim /home/heapsim/simulator2002
RUN dpkg --add-architecture i386
RUN apt-get update
RUN apt-get install -y libc6:i386 libseccomp2:i386
EXPOSE 8003
CMD ["su", "-", "heapsim", "-c", "/home/heapsim/simulator2002"]
