FROM python:3.6.4  
  
# Install  
ENV SUPERSET_VERSION 0.24.0  
  
# Set the timezone to KST  
RUN cat /usr/share/zoneinfo/Asia/Seoul > /etc/localtime  
  
RUN apt-get update && apt-get install -y \  
build-essential \  
python-dev \  
libsasl2-dev \  
libldap2-dev \  
supervisor \  
&& apt-get clean -y  
  
RUN pip --no-cache-dir install superset==${SUPERSET_VERSION} \  
mysqlclient \  
sqlalchemy-redshift \  
redis \  
celery \  
"celery[redis]" \  
Werkzeug \  
flask-oauth \  
flask_oauthlib \  
psycopg2-binary  
  
# Default config  
ENV LANG=C.UTF-8 \  
LC_ALL=C.UTF-8 \  
PATH=$PATH:/home/superset/.bin \  
PYTHONPATH=/home/superset/superset_config.py:$PYTHONPATH  
  
# Run as superset user  
WORKDIR /home/superset  
COPY superset .  
RUN groupadd -r superset && \  
useradd -r -M -g superset superset && \  
mkdir -p /home/superset/db /var/log/supervisor /var/run/supervisor && \  
chown -R superset:superset /home/superset && \  
chown -R superset:superset /var/log/supervisor && \  
chown -R superset:superset /var/run/supervisor  
  
USER superset  
  
# Deploy  
EXPOSE 8088  
HEALTHCHECK CMD ["curl", "-f", "http://localhost:8088/health"]  
  
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf  
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]  

