FROM ubuntu:trusty  
  
RUN apt-get update \  
&& apt-get upgrade -y \  
&& apt-get install -y \  
libgwenhywfar60-dev \  
libaqbanking-dev \  
python3 \  
python3-pip \  
aqbanking-tools \  
&& rm -rf /var/lib/apt/lists/*  
  
RUN pip3 install python-aqbanking flask  
  
RUN mkdir /app  
COPY app.py /app/app.py  
  
COPY entrypoint /bin/entrypoint  
RUN chmod +x /bin/entrypoint  
  
ENTRYPOINT ["/bin/entrypoint"]  
  
EXPOSE 80  

