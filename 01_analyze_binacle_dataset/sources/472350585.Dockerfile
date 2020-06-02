FROM python:3.7.1-alpine

RUN adduser -D devtuga

WORKDIR /home/devtuga

RUN apk add -U --no-cache gcc build-base linux-headers ca-certificates libffi-dev libressl-dev

COPY requirements.txt requirements.txt 
RUN python -m venv venv 
RUN venv/bin/pip install --upgrade pip
RUN venv/bin/pip install -r requirements.txt
RUN venv/bin/pip install gunicorn==19.8.1
RUN venv/bin/pip install pymysql 


COPY app app
COPY migrations migrations
COPY dev.py config.py boot.sh ./
RUN chmod +x boot.sh

ENV FLASK_APP dev.py

RUN chown -R devtuga:devtuga ./ 
USER devtuga

EXPOSE 5000
ENTRYPOINT ["./boot.sh"]