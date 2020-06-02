FROM python:jessie  
  
RUN apt-get update && apt-get install -y letsencrypt; \  
mkdir /app; \  
pip3 install watchdog PyYaml  
  
  
  
WORKDIR /app  
ADD . .  
ENV DOMAIN example.com  
ENV SUBDOMAINS "www,ww3,sub"  
ENV LE_EMAIL "exmp@example.com"  
  
ENTRYPOINT bash -c "python3 le_watch.py;bash"  

