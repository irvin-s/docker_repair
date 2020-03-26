FROM python:2-alpine  
MAINTAINER Arno0x0x - https://twitter.com/Arno0x0x  
  
RUN apk update \  
&& apk add git build-base gcc abuild binutils binutils-doc gcc-doc \  
&& git clone https://github.com/Arno0x/DBC2 dbc2 \  
&& pip install -r /dbc2/requirements.txt  
  
WORKDIR /dbc2  
  
ENTRYPOINT ["python"]  
CMD ["./dropboxC2.py"]

