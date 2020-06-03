FROM cahva/nodepm2:v3  
RUN apk add \--no-cache ffmpeg  
RUN apk add \--no-cache ffmpeg-libs  
RUN apk add \--no-cache ghostscript  
RUN apk add \--no-cache ghostscript-fonts  
RUN apk add \--no-cache imagemagick  

