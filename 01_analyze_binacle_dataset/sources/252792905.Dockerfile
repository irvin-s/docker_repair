FROM alpine  
  
COPY requirements.txt /client/  
# flag to build ssdeeplib and libfuzzy on pip install ssdeep  
ARG BUILD_LIB=1  
# TODO: put git in "build" tag once common_analysis_ssdeep is fixed  
RUN apk add --no-cache \  
git \  
python3 \  
&& \  
: packages required for building ssdeep && \  
apk add --no-cache \  
libffi \  
py3-cffi \  
&& \  
apk add --no-cache -t build \  
build-base \  
python3-dev \  
automake \  
autoconf \  
libtool \  
&& \  
pip3 install -r /client/requirements.txt && \  
apk del build  
  
# TODO: copy to /client once common_analysis_ssdeep is fixed  
COPY . /  
# WORKDIR /client  
  
CMD python3 ssdeep_analysis_instance.py  

