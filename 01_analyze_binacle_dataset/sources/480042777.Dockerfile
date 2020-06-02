FROM python:2.7
RUN apt-get update && apt-get install -y sqlite3 supervisor
RUN pip install bottle requests lxml
COPY vAPI.db  /var/www/api/vAPI.db
COPY vAPI.py /var/www/api/vAPI.py
COPY vAPI.conf /etc/supervisor/conf.d/
EXPOSE 8081
CMD /usr/bin/supervisord -c /etc/supervisor/supervisord.conf && tail -f /var/log/supervisor/supervisord.log
