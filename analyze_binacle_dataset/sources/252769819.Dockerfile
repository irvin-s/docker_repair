FROM python:2-alpine  
MAINTAINER Arno0x0x - https://twitter.com/Arno0x0x  
  
RUN apk update \  
&& apk add git build-base gcc abuild binutils binutils-doc gcc-doc \  
&& git clone https://github.com/zerosum0x0/koadic koadic \  
&& pip install -r /koadic/requirements.txt  
  
WORKDIR /koadic  
  
ENTRYPOINT ["python"]  
CMD ["./koadic"]

