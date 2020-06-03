FROM python:3.6  
WORKDIR /usr/src/app  
  
RUN apt-get update \  
&& apt-get install -y libsnappy-dev jq \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists/*  
  
COPY setup.py /usr/src/app/  
RUN pip install --no-cache-dir --upgrade pip \  
&& pip install .  
  
COPY franz/*.py /usr/src/app/franz/  
RUN pip install -e .  
  
COPY LICENSE /usr/src/app/  
COPY README.md /usr/src/app/  
  
CMD ["sleep", "365d"]  

