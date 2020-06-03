FROM python:3  
RUN apt-get update && apt-get install -y \  
libxml2-dev \  
libxslt-dev \  
python-dev \  
&& rm -rf /var/lib/apt/lists/*  
  
RUN mkdir -p /srv/iso /srv/iso_harvest /var/log/iso_harvest  
  
WORKDIR /srv/iso_harvest  
  
COPY . /srv/iso_harvest  
  
RUN pip install /srv/iso_harvest  
  
VOLUME /srv/iso  
  
CMD python /srv/harvest.py  

