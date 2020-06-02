FROM python:3-alpine

WORKDIR /usr/src/app

RUN pip install --no-cache-dir nltk

COPY SAR_indexer.py .
COPY mini_enero ./mini_enero
COPY SAR_utils.py .

RUN python SAR_indexer.py mini_enero mini_enero.data

COPY SAR_searcher_lib.py .
COPY SAR_server.py .

EXPOSE 2048

CMD [ "python", "SAR_server.py", "mini_enero.data" ]
