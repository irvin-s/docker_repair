FROM mongo:3.0  
RUN apt-get update \  
&& apt-get install -y --no-install-recommends \  
python-pip python-dev build-essential \  
&& rm -rf /var/lib/apt/lists/*  
  
RUN pip install pymongo mtools  
  
COPY docker-entrypoint.sh /entrypoint.sh  
RUN chmod +x /entrypoint.sh  
  
ENTRYPOINT ["/entrypoint.sh"]  
CMD ["mlaunch"]

