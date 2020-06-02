FROM python:3.6.6-stretch

WORKDIR /usr/src/pugma-bot

COPY . .

RUN pip install -r requirements.txt

CMD ["python", "app/bot.py"]
