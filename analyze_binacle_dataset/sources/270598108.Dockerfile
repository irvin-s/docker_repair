FROM debian:jessie

RUN apt-get update && \
  apt-get install -y apt-transport-https && \
  apt-get install -y curl git python python-pip && \
  echo 'deb http://httpredir.debian.org/debian jessie-backports main non-free' >> /etc/apt/sources.list && \
  echo 'deb-src http://httpredir.debian.org/debian jessie-backports main non-free' >> /etc/apt/sources.list && \
  apt-get update && \
  apt-get install -y libav-tools && \
  apt-get install -y ffmpeg && \
  mkdir s2c && \
  cd s2c && \
  git clone https://github.com/Pat-Carter/stream2chromecast.git

COPY start-stream.sh /root/s2c/start-stream.sh
RUN chmod +x /root/s2c/start-stream.sh
#ENTRYPOINT ["/usr/local/bin/start-stream.sh"]
VOLUME ["/root/s2c"]
#CMD [" ./start-stream.sh bash"]
CMD ["/bin/bash","/root/s2c/start-stream.sh"]

