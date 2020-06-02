FROM python:3-slim  
  
WORKDIR /0bin  
  
EXPOSE 8000  
COPY . /0bin/  
  
RUN \  
pip install . \  
&& chown -R www-data:www-data .  
  
USER www-data  
  
CMD python zerobin.py  

