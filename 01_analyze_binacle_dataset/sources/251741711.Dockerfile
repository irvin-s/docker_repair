# Start with ffmpeg image
FROM nightseas/ffmpeg:cuda8.0-ubuntu16.04

MAINTAINER Xiaohai Li <haixiaolee@gmail.com>

COPY ffserver.conf /etc/ffserver.conf

# HTTP: 8090, RTP: 554
EXPOSE 8090 554

CMD bash -c "ffserver"
