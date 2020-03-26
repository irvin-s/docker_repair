FROM debian:jessie  
  
RUN apt-get update  
  
ENV DEBIAN_FRONTEND noninteractive  
RUN apt-get install -y --no-install-recommends python python-pip git  
  
RUN git clone https://github.com/passiomatic/coldsweat.git /coldsweat  
  
ADD customization/config /coldsweat/etc/config  
  
WORKDIR /coldsweat  
  
RUN pip install -r requirements.txt  
  
CMD ["python", "sweat.py", "serve", "-r"]  

