FROM python:3.6-alpine

COPY . /app
WORKDIR /app

RUN ls
RUN pip install -r requirements.txt

CMD python3 wiki.py "${WIKINAME}" w 80 /var/wiki/pages /var/wiki/service_pages /var/wiki/assets 
