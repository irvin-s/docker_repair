# start with a base image
FROM ubuntu:16.04

# install dependencies
RUN apt-get -y update
RUN apt-get install -y python python-dev python-pip

# add requirements.txt and install
COPY requirements.txt /code/requirements.txt
COPY server/ /code/server/
COPY wsgi.py /code/wsgi.py
RUN pip install -r /code/requirements.txt

WORKDIR /code

# Run that shit
CMD ["gunicorn", "wsgi:app", "-b", "0.0.0.0:5000"]

EXPOSE 5000
