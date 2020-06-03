FROM ubuntu:16.04
RUN apt-get update -y
RUN apt-get install -y python-pip python-dev build-essential python-setuptools
WORKDIR /app
ADD . /app
RUN pip install -r requirements.txt
CMD ["gunicorn", "-c", "config.py", "app:app"]
