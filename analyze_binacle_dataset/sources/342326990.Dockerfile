FROM python:3.6-slim

WORKDIR /root/connect

COPY ./requirements.txt ./requirements.txt
ENV MYSTR_HOME /root/connect/platform/software
ENV PYTHONPATH $MYSTR_HOME/lib/
RUN apt-get update && apt-get upgrade -y && pip install -r requirements.txt

CMD /bin/bash