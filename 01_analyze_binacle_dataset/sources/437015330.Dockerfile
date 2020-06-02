FROM python:3.7

# docker build -t trumpbot .

RUN apt-get update && \
    apt-get install -y python-numpy && \
    mkdir -p /code

ADD . /code
WORKDIR /code
RUN pip install -r requirements.txt

ENTRYPOINT ["python"]
CMD ["/code/trumpbot.py"]
