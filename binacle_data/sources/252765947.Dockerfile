FROM ubuntu:16.04  
MAINTAINER Ruben Callewaert <rubencallewaertdev@gmail.com>  
  
RUN apt-get update && apt-get install -y --no-install-recommends \  
python3-pip \  
git \  
sudo \  
ffmpeg \  
libopus-dev \  
libffi-dev \  
build-essential \  
python3-dev \  
nano \  
&& apt-get clean  
  
RUN pip3 install --upgrade pip  
RUN pip3 install setuptools  
RUN pip3 install wheel  
RUN pip3 install cffi  
  
COPY init.sh /init.sh  
  
RUN chmod -v +x /init.sh  
  
RUN mkdir /app  
  
RUN useradd -u 911 -U -d /config -s /bin/false abc  
  
VOLUME /app  
WORKDIR /app  
  
CMD ["/init.sh"]  

