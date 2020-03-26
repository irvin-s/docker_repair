FROM ubuntu

RUN apt-get update && apt-get install -y python3-pip
RUN pip3 install --upgrade pip
RUN pip3 install flask-restful ipfsapi requests

ADD ./agent.py /agent.py
ENTRYPOINT ["/agent.py"]
