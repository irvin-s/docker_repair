FROM ubuntu:14.04  
  
MAINTAINER "Misha Behersky" bmwant@gmail.com  
  
RUN rm -rf /var/lib/apt/lists/ \  
&& apt-get update \  
&& apt-get install -y --no-install-recommends \  
sudo \  
python3-pip \  
python3-dev \  
build-essential \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists/  
  
RUN pip3 install flower  
  
RUN mkdir -p /etc/flower /var/flower/db  
  
COPY flowerconfig.py /etc/flower/flowerconfig.py  
  
EXPOSE 5555  
  
CMD ["flower --conf=/etc/flower/flowerconfig.py"]  

