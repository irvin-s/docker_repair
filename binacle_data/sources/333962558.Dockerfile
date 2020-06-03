FROM python:3.6.1
LABEL maintener="Michell Stuttgart <michellstut@gmail.com>"

# Create the group and user to be used in this container
RUN groupadd flaskgroup && useradd -m -g flaskgroup -s /bin/bash flask 

RUN mkdir -p /home/flask/app/web
WORKDIR /home/flask/app/web

COPY requirements.txt /home/flask/app/web
RUN pip install --no-cache-dir -r requirements.txt

COPY . /home/flask/app/web

RUN chown -R flask:flaskgroup /home/flask

USER flask