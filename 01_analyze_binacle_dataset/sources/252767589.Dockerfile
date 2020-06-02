FROM alpine:latest  
  
RUN apk add --update \  
bash \  
git \  
openssh \  
python \  
py-pip \  
&& rm -rf /var/cache/apk/*  
  
RUN pip install giturlparse.py  
  
RUN mkdir /root/.ssh/  
RUN chmod 700 /root/.ssh/  
  
COPY gethost.py /gethost.py  
COPY clone.sh /clone.sh  
  
VOLUME /root/.ssh/id_rsa  
VOLUME /repo  
  
ENTRYPOINT '/clone.sh'

