FROM ubuntu:14.04
MAINTAINER John-Paul Stanford <dev@stanwood.org.uk>

VOLUME /tmp

RUN apt-get update -y && \
    apt-get install -y software-properties-common && \
    add-apt-repository -y ppa:ubuntu-wine/ppa && \
    apt-get update -y && \
    dpkg --add-architecture i386 && \
    apt-get update -y && \
    apt-get install -y wine1.7 winetricks xvfb wget p7zip-full && \
    mkdir -p /extracted
    
#RUN apt-get purge -y python-software-properties && \
#    apt-get autoclean -y
    
# Download itunes 12 64 Bit
RUN mkdir -p /extracted && cd /extracted && wget -O itunes-installer.exe https://secure-appldnld.apple.com/iTunes12/031-08059.20141016.FrPFF/iTunes64Setup.exe
# Download itunes 12 32 Bit
# RUN mkdir -p /extracted && cd /extracted && wget -O itunes-installer.exe https://secure-appldnld.apple.com/iTunes12/031-08058.20141016.34epp/iTunesSetup.exe

ENV WINEPREFIX /windows
#ADD ./iTunesSetup.exe /extracted/itunes-installer.exe

RUN cd /extracted && \
    7z e itunes-installer.exe && \
    mkdir -p /windows/drive_c && \
    mv /extracted/* /windows/drive_c/

#RUN rm -rf /extracted

RUN cd /windows/drive_c/
RUN wine msiexec /i c:/AppleApplicationSupport.msi /qn
RUN wine msiexec /i c:/Bonjour64.msi /qn
#RUN wine msiexec /i c:/iTunes64Setup.exe /qn

#RUN wine /tmp/itunes.exe

#RUN winetricks riched20

CMD /usr/bin/itunes.sh
