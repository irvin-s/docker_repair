# vim:set ft=dockerfile ts=1 sw=1 ai et:  
FROM python:2  
RUN pip install --no-cache-dir gunicorn  
  
COPY . /srv/docker-leash  
RUN pip install --no-cache-dir -e /srv/docker-leash/  
  
CMD ["gunicorn", "--workers=5", "--bind=[::]:80", "docker_leash.wsgi:app"]  

