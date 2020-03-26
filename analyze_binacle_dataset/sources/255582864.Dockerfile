FROM python:3-alpine

WORKDIR /usr/src/app

RUN pip install python-telegram-bot

COPY bot.py .

ENV SERVER_URL=localhost
ENV SERVER_PORT=2048

CMD [ "python", "bot.py" ]
