FROM python:3.6-slim
LABEL maintainer Garrett Hoffman <garrett@stocktwits.com>

RUN apt-get update && apt-get install -y \
    libpq-dev \ 
    python3-dev \
    gcc \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /src/
WORKDIR /src

COPY requirements.txt /src

RUN pip3 install --upgrade pip && \
    pip3 install -r requirements.txt 

COPY agg_sent_minutely.py /src/

CMD [ "python", "agg_sent_minutely.py" ]