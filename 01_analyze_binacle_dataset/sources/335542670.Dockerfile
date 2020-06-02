FROM python:3.6

ENV USR nonroot
ENV HOME /home/$USR
ENV PYTHONUNBUFFERED 1

EXPOSE 5000

RUN groupadd -g 1000 -r $USR && \
  useradd -u 1000 -d $HOME -m -r -g $USR $USR

WORKDIR $HOME

RUN pip install --no-cache-dir \
  empty==0.4.3\
  eventlet==0.22.0\
  flask-marshmallow==0.8.0\
  flask-migrate==2.1.1\
  flask-restful==0.3.6\
  flask-security==3.0.0\
  flask-socketio==2.9.3\
  flask-sqlalchemy==2.3.2\
  flask-rq2==17.2\
  marshmallow-sqlalchemy==0.13.2\
  psycopg2==2.7.3.2\
  redis==2.10.6

COPY --chown=1000:1000 . .

USER $USR
CMD ["flask", "run", "-h", "0.0.0.0"]