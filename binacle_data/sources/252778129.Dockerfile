FROM python:2.7-alpine  
MAINTAINER Jonathan Meyer <jon@gisjedi.com>  
  
LABEL name="DCOS GeoServer Bootstrap Image" \  
vendor="Applied Information Sciences" \  
license="Apache v2.0"  
  
COPY requirements.txt /  
RUN pip install --no-cache-dir -r requirements.txt  
  
RUN mkdir -p /opt/gs-sync  
  
COPY . /opt/gs-sync/  
RUN chmod +x /opt/gs-sync/*.py \  
&& chmod +x /opt/gs-sync/*.sh  
  
EXPOSE 8000  
WORKDIR /opt/gs-sync  
CMD ["./wrapper.sh"]  

