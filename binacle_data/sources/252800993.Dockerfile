# ffmpeg - http://ffmpeg.org/download.html  
#  
  
FROM dppereyra/python-speech  
  
EXPOSE 80  
EXPOSE 443  
EXPOSE 8080  
  
RUN apk update \  
&& apk add --no-cache --virtual=.build-dependencies \  
g++ \  
gfortran \  
file \  
binutils \  
musl-dev \  
python3-dev \  
build-base \  
&& update-ca-certificates \  
&& ln -s locale.h /usr/include/xlocale.h \  
&& pip install \  
tornado \  
wsaccel \  
&& find /usr/local/lib/python3.*/ -name 'tests' -exec rm -r '{}' \+ \  
&& rm /usr/include/xlocale.h \  
&& rm -r /root/.cache \  
&& apk del .build-dependencies \  
&& rm -rf /var/cache/apk/* \  
&& rm -rf /tmp/*  
  
VOLUME [ \  
"/usr/local/lib/python3.6/site-packages/spacy/data", \  
"/root/polyglot_data", \  
"/root/nltk_data", \  
"/usr/local/lib/python3.6/site-packages/en_core_web_sm", \  
"/usr/local/lib/python3.6/site-packages/en_core_web_lg", \  
"/usr/local/lib/python3.6/site-packages/en_vectors_web_lg" \  
]  

