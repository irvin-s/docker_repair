# Use same base as postgres to minimize total size  
FROM debian:wheezy  
  
RUN apt-get update \  
&& apt-get install -y python curl \  
&& rm -rf /var/lib/apt/lists/* \  
&& curl -SL 'https://bootstrap.pypa.io/get-pip.py' | python  
  
ENV PYTHONUNBUFFERED 1  
ADD app /app  
WORKDIR /app  
  
RUN pip install -r requirements.txt  
  
CMD ["python2", "agent.py"]  

