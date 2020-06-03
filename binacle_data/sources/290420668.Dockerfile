FROM python:3.6.3

WORKDIR /app

COPY requirements.txt .

RUN pip install -r requirements.txt

COPY . .

CMD ["scrapy", "crawl", "tabelog"]
