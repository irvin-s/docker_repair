FROM python:2.7.12
MAINTAINER Andrew Krug "andrewkrug@gmail.com"
RUN mkdir /root/.ssh
COPY ./id_rsa /root/.ssh/id_rsa
COPY ./ssh_config /root/.ssh/config
RUN chmod 600 /root/.ssh/id_rsa
RUN mkdir -p /app
ADD . /app
WORKDIR /app
RUN pip install -r requirements.txt
RUN pip install gunicorn
RUN useradd celery-worker 
RUN rm -f /app/static/packed.js
RUN rm -f /app/static/all.css
CMD ["/app/docker-entrypoint.sh"]
