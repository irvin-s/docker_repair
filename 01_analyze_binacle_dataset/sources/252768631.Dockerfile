FROM alpine:edge  
  
MAINTAINER AHAPX  
MAINTAINER anarchy.b@gmail.com  
  
RUN apk add --no-cache python3 git && \  
python3 -m ensurepip && \  
rm -r /usr/lib/python*/ensurepip && \  
pip3 install --upgrade pip setuptools && \  
rm -r /root/.cache  
  
RUN git clone https://github.com/AHAPX/smtpush.git /smtpush  
RUN pip3 install -U pip  
RUN pip3 install -r /smtpush/requirements.txt  
  
VOLUME /smtpush  
WORKDIR /smtpush  
  
CMD python3 smtpush.py -c config.cfg  
  

