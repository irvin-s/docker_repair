FROM python:latest

WORKDIR /jcoin
ADD . /jcoin

# RUN apk add --no-cache alpine-sdk git
RUN pip3 install -Ur requirements.txt

ENV NAME jcoin

CMD ["python3", "josecoin.py"]
