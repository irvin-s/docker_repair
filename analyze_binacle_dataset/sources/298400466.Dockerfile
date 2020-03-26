FROM ubuntu

RUN apt-get update -y && apt-get install -y python3 python3-pip python3-dev build-essential

COPY ./source/python /python
WORKDIR /python
RUN pip3 install -r requirements.txt

CMD python3 /python/d4d/flask_app.py
