FROM python:3.5-alpine

WORKDIR /usr/src/proxybot

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY proxybot . 

CMD ["python", "proxy_bot.py"]
