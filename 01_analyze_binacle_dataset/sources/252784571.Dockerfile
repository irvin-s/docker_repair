FROM python:latest  
MAINTAINER Justin Willis <sirJustin.Willis@gmail.com>  
  
ENV DEBIAN_FRONTEND noninteractive  
  
COPY AUTHORS CHANGELOG.md LICENSE README.md setup.py /opt/d3cryp7.py/  
COPY d3cryp7/ /opt/d3cryp7.py/d3cryp7/  
COPY docs/ /opt/d3cryp7.py/docs/  
COPY tests/ /opt/d3cryp7.py/test/  
  
RUN apt-get update \  
&& apt-get install -y --no-install-recommends \  
tesseract-ocr \  
&& pip3 install /opt/d3cryp7.py \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
EXPOSE 80  
VOLUME ~  
  
ENTRYPOINT ["python3", "/opt/d3cryp7.py/d3cryp7"]  

