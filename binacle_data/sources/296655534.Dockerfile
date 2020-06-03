FROM python:slim

RUN apt-get update && apt-get install -y git  && \
    mkdir /opt/cvechk && \
    apt-get -y autoremove && apt-get clean

WORKDIR /opt/cvechk
RUN git clone https://github.com/evitalis/cvechk.git /opt/cvechk && \
    pip install -r requirements.txt

RUN sed -i -e "s/127.0.0.1/redis/" config.py

ENTRYPOINT ["python", "/opt/cvechk/run.py"]
