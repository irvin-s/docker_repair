FROM alpine:3.3  
MAINTAINER Bart Bania <contact@bartbania.com>  
  
RUN apk add --no-cache --update \  
python \  
openssh-client \  
&& rm -rf /var/cache/apk/*  
  
COPY ./menu.py ./menulist.py /  
  
RUN mkdir /root/.ssh \  
&& chmod 700 /root/.ssh/  
  
CMD [ "python", "/menu.py" ]  
  

