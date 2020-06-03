FROM python:3.6-alpine

RUN apk add --no-cache -u gcc make musl-dev
RUN pip install dumb-init

COPY requirements.txt /app/
WORKDIR /app
RUN pip install -r requirements.txt

COPY . /app

CMD ["dumb-init", "python3", "-u", "/app/run.py"]
