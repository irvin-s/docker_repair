FROM ubuntu:trusty

RUN apt-get update && apt-get install python-flask python-pip python-dev msgpack-python -y
RUN pip install cocaine

ADD worker.py /usr/bin/cocaine-lab/
ADD app.py /usr/bin/cocaine-lab/
