FROM python:3-alpine  
MAINTAINER Amane Katagiri  
CMD [""]  
ENTRYPOINT ["pykick"]  
WORKDIR /pykick  
COPY . /pykick  
COPY ./pykick/example /app  
RUN pip install -e .  
WORKDIR /app  

