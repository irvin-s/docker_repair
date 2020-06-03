from python:3.7


WORKDIR /app

ADD . /app

RUN pip install -r requirements.txt

CMD ["python", "-m", "tweetsjb"]