FROM alpine:3.4  
  
ENV VERSION=1.0  
  
RUN apk add --no-cache --virtual .build-deps \  
build-base \  
&& apk add --no-cache --virtual .run-deps \  
python-dev \  
git \  
py-pip \  
jpeg-dev \  
zlib-dev \  
freetype-dev \  
lcms2-dev \  
openjpeg-dev \  
tiff-dev \  
tk-dev \  
tcl-dev \  
harfbuzz-dev \  
fribidi-dev \  
imagemagick-dev \  
&& git clone https://github.com/eea/pdfdiff.git \  
&& cd pdfdiff \  
&& git checkout $VERSION \  
&& pip install . \  
&& cd ../ \  
&& apk del .build-deps \  
&& rm -rf pdfdiff/  
  
COPY docker-entrypoint.sh /  
  
ENTRYPOINT ["/docker-entrypoint.sh"]  
CMD ["pdfdiff"]  

