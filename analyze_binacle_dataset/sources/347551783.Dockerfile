FROM python:alpine

COPY . /opt/mdweb

WORKDIR /opt/mdweb

RUN pip install -r /opt/mdweb/requirements/production.txt

EXPOSE 5000

CMD ["gunicorn", "--workers=4", "-b 0.0.0.0:5000","wsgi:app"]
