FROM ubuntu:latest

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -y update

RUN apt-get -y install dosbox

RUN apt-get -y install curl
RUN apt-get -y install zip unzip

RUN apt-get -y install python python-flask

ENV SDL_VIDEODRIVER dummy

# Install OLDDOS.EXE utils.
RUN mkdir -p /root/dos

WORKDIR /root/dos

# Using two sources since TravisCI seems to have trouble connecting to archive.org.
RUN curl \
    -L \
    -o "./olddos.exe" \
    "https://web.archive.org/web/20120215074213/http://download.microsoft.com/download/win95upg/tool_s/1.0/w95/en-us/olddos.exe" \
    || \
    curl \
    -L \
    -o "./olddos.exe" \
    "http://www.pcxt-micro.com/download/olddos.exe"

ADD olddos.exe.sha1 ./olddos.exe.sha1

RUN sha1sum -c ./olddos.exe.sha1

RUN zip -J "./olddos.exe"
RUN yes | unzip "./olddos.exe"
RUN rm "./olddos.exe"

# DosBox config file
RUN mkdir -p /root/.dosbox
COPY dosbox.conf "/root/.dosbox/dosbox-0.74.conf"

# Program itself
COPY MORSE.BAS "/root/dos/MORSE.BAS"

# The proxy
RUN mkdir -p /root/proxy
COPY proxy.py /root/proxy/proxy.py

WORKDIR /root/proxy

CMD [ "python", "proxy.py" ]
