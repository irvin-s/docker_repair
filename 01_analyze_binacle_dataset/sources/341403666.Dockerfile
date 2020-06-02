FROM registry.opensource.zalan.do/stups/python:latest

COPY requirements.txt /
RUN pip3 install -r /requirements.txt

COPY app.py /

VOLUME /tmp

CMD /app.py

COPY scm-source.json /
