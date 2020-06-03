FROM ubuntu:16.04

RUN ["apt-get", "update"]
RUN ["apt-get", "-y", "install", "vlc-nox"]

RUN ["mkdir", "-p", "/server"]
RUN ["useradd", "rtsp-server"]

COPY morse.flac /server/stream.flac
COPY vlc.sh /server/vlc-stream

CMD ["chmod", "755", "/server/vlc-stream"]

CMD ["/server/vlc-stream"]
