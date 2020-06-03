FROM debian:stretch  
MAINTAINER nobody@nowhere.ws  
  
RUN set -x \  
&& apt-get update && apt-get install -y --no-install-recommends \  
gir1.2-poppler-0.18 \  
python-cairo \  
python-gi \  
python-gi-cairo \  
python-gobject \  
python-pip \  
python-setuptools \  
python-wheel  
  
RUN mkdir /srv/eventmap  
WORKDIR /srv/eventmap  
COPY requirements.txt /srv/eventmap/requirements.txt  
  
RUN pip install -r requirements.txt  
  
COPY ./ /srv/eventmap  
  
VOLUME [ "/srv/eventmap/data" ]  
  
CMD [ "python", "run_server.py", "-P" ]  
  
EXPOSE 8023  

