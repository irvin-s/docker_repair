FROM ubuntu:18.04

RUN apt-get update
RUN apt-get install -y build-essential python3 python3-pip

# update pip
RUN pip3 install pip --upgrade
RUN pip3 install wheel

COPY . /livermore
WORKDIR /livermore
RUN pip3 install -r requirements.txt
RUN python3 -m unittest discover app/test
CMD python3 -m cProfile -s tottime main.py data.raw
