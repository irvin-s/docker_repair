FROM alpine:3.5  
  
WORKDIR /data  
  
COPY . /data  
  
RUN set -ex; apk --no-cache update && apk --no-cache add ffmpeg  
  
CMD ["/usr/bin/ffplay", "flatlanders"]  
  
####################################################  
# #  
# docker run --rm \ #  
# -v /tmp/.X11-unix:/tmp/.X11-unix \ #  
# -e DISPLAY \ #  
# --device /dev/snd \ #  
# flatlanders:latest #  
# #  
####################################################  
  

