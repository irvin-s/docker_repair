FROM python:3.6.4-alpine  
  
ENV ISSO_VERSION=0.10.6 \  
ISSO_SETTINGS=/etc/isso/default.cfg  
  
# deps  
RUN apk add -U --no-cache build-base \  
&& pip install --no-cache-dir --upgrade \  
gunicorn isso==${ISSO_VERSION} \  
&& apk del build-base  
  
# runtime config  
COPY default.cfg /etc/isso/default.cfg  
COPY docker-entrypoint.sh isso_settings.py /usr/bin/  
ENTRYPOINT ["docker-entrypoint.sh"]  
CMD ["gunicorn", "-b", "0.0.0.0:80", "isso.dispatch"]  
EXPOSE 80  

