FROM olympus_base:latest

COPY . /

RUN apt-get update && \
    apt-get install -y python3 python3-pip && \
    \
    pip3 install -r requirements.txt


CMD python3 -m alvi.server --port=8000
