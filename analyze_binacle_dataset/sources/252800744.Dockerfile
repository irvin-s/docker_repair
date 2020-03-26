FROM dorftv/ffmpeg-core  
MAINTAINER Stefan Hageneder <stefan.hageneder@dorftv.at>  
  
CMD ["--help"]  
ENTRYPOINT ["ffprobe"]  

