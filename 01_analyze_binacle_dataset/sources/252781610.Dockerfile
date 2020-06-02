FROM bardiir/web-optim-dash-hls  
  
RUN tools="imagemagick \  
  
bash" && \  
apk add \--no-cache --update ${tools} && \  
rm -rf /var/cache/apk/*  

