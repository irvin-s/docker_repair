FROM python:3
ADD requirements.txt /requirements.txt
RUN pip install -r requirements.txt
ADD . /
EXPOSE 5000
CMD [ "gunicorn", "--name", "mee6_web", "--workers", "16", "-k", "gevent", "--timeout", "120", "--bind", "0.0.0.0:5000", "app:app" ]
