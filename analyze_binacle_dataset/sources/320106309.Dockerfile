FROM jrottenberg/ffmpeg:3.3-alpine

RUN apk add --no-cache bash
ADD root /
WORKDIR /tmp/ffmpeg

ENTRYPOINT ["/opt/video2gif/ffmpeg2gif.sh"]



