FROM ubuntu:16.04

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install python-pip -y
RUN pip install requests flask flask-sqlalchemy SQLAlchemy-Utils gunicorn

COPY kws_main_server/ /opt/kws_main_server/

#CMD ["python", "/opt/kws_main_server/server.py"]
WORKDIR /opt/kws_main_server
CMD ["gunicorn", "-b", "0.0.0.0:8000", "-w", "16", "server:app"]
