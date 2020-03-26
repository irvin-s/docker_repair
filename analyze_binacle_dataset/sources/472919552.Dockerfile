FROM ubuntu:18.04

RUN apt-get update

RUN apt-get install -y python3.6 python3-pip

WORKDIR /app
COPY requirements.txt /app

RUN pip3 install -r requirements.txt

COPY . /app


RUN apt-get -qq -y autoremove \
    && apt-get autoclean \
    && rm -rf /var/lib/apt/lists/* /var/log/dpkg.log

RUN python3 /app/src/test_foremast_brain.py

EXPOSE 5000
WORKDIR /app/src
ENTRYPOINT ["python3", "./aiforemast.py"]
