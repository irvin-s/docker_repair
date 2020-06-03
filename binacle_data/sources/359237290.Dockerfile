FROM python:2.7-alpine

RUN apk add --no-cache bash 

RUN mkdir -p slack-telegram
COPY . /slack-telegram
COPY ./entrypoint.sh /slack-telegram/slack-telegram/src/

WORKDIR /slack-telegram/slack-telegram/src/

RUN pip install --upgrade pip
RUN pip install -r ../requirements.txt

ENTRYPOINT ["/bin/bash", "./entrypoint.sh"]
CMD ["python", "bridge.py"]

