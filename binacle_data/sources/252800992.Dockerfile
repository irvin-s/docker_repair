# ffmpeg - http://ffmpeg.org/download.html  
#  
# Based on https://hub.docker.com/r/jrottenberg/ffmpeg/  
# and https://hub.docker.com/r/frolvlad/alpine-python-machinelearning/  
#  
  
FROM dppereyra/python-ffmpeg-audio:py3.6-ffmpeg3.4  
  
RUN mkdir -p /applib  
COPY stack-fix.c /applib/  
  
RUN apk update \  
&& apk add --no-cache icu openblas \  
&& apk add --no-cache --virtual=.build-dependencies \  
g++ \  
gfortran \  
file \  
binutils \  
musl-dev \  
python3-dev \  
build-base \  
linux-headers \  
libffi-dev \  
openssl-dev \  
openblas-dev \  
icu-dev \  
&& update-ca-certificates \  
&& ln -s locale.h /usr/include/xlocale.h \  
&& gcc -shared -fPIC /applib/stack-fix.c -o /applib/stack-fix.so \  
&& pip install numpy==1.14.* \  
&& pip install scipy==1.0.* \  
&& pip install \  
pandas==0.22.* \  
scikit-learn==0.19.* \  
cryptography==2.2.* \  
bcrypt==3.1.* \  
bottleneck==1.2.* \  
numexpr==2.6.* \  
pydub==0.21.* \  
speechrecognition==3.8.* \  
nltk==3.2.* \  
spacy==2.0.* \  
polyglot==16.7.* \  
pyicu==2.0.* \  
pycld2==0.31 \  
morfessor==2.0.* \  
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

