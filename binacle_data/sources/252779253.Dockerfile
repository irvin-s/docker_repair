FROM python:3-alpine3.7  
RUN apk update \  
&& apk add \--update musl-dev git gcc --no-cache \  
&& pip install streamlink requests colorama \  
&& git clone https://github.com/beaston02/CamsodaRecorder -b test /cs \  
&& rm /cs/wanted.txt && rm /cs/config.conf \  
&& apk del git gcc --no-cache \  
&& rm -Rf /tmp/*  
COPY config.conf /cs/config.conf  
CMD cd /cs && python main.py  

