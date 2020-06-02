FROM ubuntu:trusty

RUN \
  apt-get update && \
  apt-get install -y sudo lame faad libid3-tools python-pip && \
  apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN \
  pip install mutagen==1.23

COPY init.sh rename.sh m4a2mp3 MP3_FileRename_FromID3.py /usr/local/bin/

ENV USERID 500
ENV GROUPID 100

ENTRYPOINT ["/usr/local/bin/init.sh", "/usr/local/bin/rename.sh"]
#CMD ["/usr/local/bin/rename.sh"]
