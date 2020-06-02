FROM python:2.7.11

WORKDIR /usr/local/src/twitter-to-kafka-CGA

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

# Do this last; most likely to change
COPY src/twitter-to-kafka-CGA.py ./

CMD ["python2", "twitter-to-kafka-CGA.py"]
