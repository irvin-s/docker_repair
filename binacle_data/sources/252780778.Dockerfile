FROM masterandrey/docker-python-base  
  
COPY pip.requirements.txt /pip.requirements.txt  
  
RUN pip install -r pip.requirements.txt \  
&& apk del python3-dev libxslt-dev libxml2-dev \  
&& rm -rf ~/.pip/cache/ \  
&& rm -rf /var/cache/apk/*  
  
COPY src/* /amazon_dash/  
  
WORKDIR "/amazon_dash"  
CMD ["python3", "wifi-sniff.py"]  

