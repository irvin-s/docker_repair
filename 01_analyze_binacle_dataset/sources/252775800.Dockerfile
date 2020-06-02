FROM python:3.5-slim  
  
RUN mkdir -p /usr/src/caliper /usr/src/caliper-docs  
WORKDIR /usr/src/caliper  
COPY requirements.txt /usr/src/caliper/  
RUN pip3 install -r requirements.txt  
  
COPY . /usr/src/caliper  
RUN python3 setup.py install  
  
WORKDIR /usr/src/caliper/docs  
RUN sphinx-build -b html -d build/doctrees source build/html  
  
RUN mv build/html/* /usr/src/caliper-docs/  
  
WORKDIR /usr/src/caliper-docs  
RUN rm -rf /usr/src/caliper  
  
ENV PYTHONUNBUFFERED=1  
CMD ["python", "-m", "http.server"]  

