FROM centos:7  
ENV FFMPEG_VERSION=2.8.3 \  
YASM_VERSION=1.3.0 \  
OGG_VERSION=1.3.2 \  
VORBIS_VERSION=1.3.5 \  
THEORA_VERSION=1.1.1 \  
LAME_VERSION=3.99.5 \  
OPUS_VERSION=1.1 \  
FAAC_VERSION=1.28 \  
VPX_VERSION=1.4.0 \  
XVID_VERSION=1.3.4 \  
FDKAAC_VERSION=0.1.4 \  
X265_VERSION=1.8 \  
CHUNK_LEN=30  
WORKDIR /tmp/workdir  
  
COPY scripts /scripts  
  
RUN chmod 777 /scripts/*.sh  
RUN /scripts/run.sh  
  
CMD ["/scripts/master.sh"]  

