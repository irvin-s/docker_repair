FROM python:2.7.12-alpine  
RUN apk add --update git build-base  
RUN git clone https://github.com/TBTerra/spawnScan.git /opt/spawnScan  
WORKDIR /opt/spawnScan  
RUN chmod 755 *.py \  
&& pip install -r requirements.txt  
RUN mkdir work \  
&& mv config.json work/ \  
&& ln -s work/config.json config.json \  
&& ln -s work/pokes.json pokes.json \  
&& ln -s work/spawns.json spawns.json \  
&& ln -s work/stops.json stops.json \  
&& ln -s work/gyms.json gyms.json  
VOLUME work  
ENTRYPOINT ["python"]  
CMD ["spawn.py"]  

