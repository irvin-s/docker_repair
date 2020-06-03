FROM tiangolo/uwsgi-nginx-flask:python2.7

COPY . /app
RUN pip install -r requirements.txt