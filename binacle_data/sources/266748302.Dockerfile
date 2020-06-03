FROM python:3.6

ENV PYTHONUNBUFFERED 1

RUN mkdir -p /usr/src/miley
WORKDIR /usr/src/miley

ADD requirements.txt .
RUN pip install -r requirements.txt

ADD . /usr/src/miley
# RUN python3 manage.py migrate

# CMD ["sh", "bin/server"]
# EXPOSE 8000
