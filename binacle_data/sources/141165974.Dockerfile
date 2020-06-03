#Creating Ubuntu 16.04 Base Image
FROM ubuntu:16.04
EXPOSE 8080

#Install Python 3.6 on the image
RUN apt-get update && apt-get install -y software-properties-common
RUN add-apt-repository ppa:jonathonf/python-3.6
RUN apt-get update
RUN apt-get update && apt-get install -y curl
RUN apt-get install -y build-essential python3.6 python3.6-venv

RUN mkdir serviceunit
ADD serviceunit.py /serviceunit/serviceunit.py
ADD requirements.txt /serviceunit/requirements.txt
ADD start.sh /serviceunit/start.sh

#Set up Python virtual environment
RUN python3.6 -m venv /python3.6-venv
RUN bash -c "source /python3.6-venv/bin/activate && \
       /python3.6-venv/bin/pip3.6 install wheel setuptools nose coverage && \
       /python3.6-venv/bin/pip3.6 install -r /serviceunit/requirements.txt"

CMD ["sh", "/serviceunit/start.sh"]
