FROM python:2.7-slim  
  
WORKDIR /usr/lib/kodi-alexa  
  
ENV GUNICORN_LOGLEVEL info  
  
ADD ./entrypoint.sh /  
  
RUN apt-get update && apt-get -y install git gcc && \  
git clone https://github.com/caphm/kodi-alexa.git . && \  
pip install -r requirements.txt && \  
pip install python-Levenshtein && \  
apt-get -y remove git gcc && \  
apt-get -y autoremove && \  
chmod +x /entrypoint.sh  
  
EXPOSE 8000  
VOLUME /config  
  
ENTRYPOINT ["/entrypoint.sh"]  

