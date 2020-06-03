FROM arm32v7/python:3.6-slim

RUN mkdir -p /app/pytel_bot
WORKDIR /app/

COPY requirements.txt .
RUN apt-get update && \
    apt-get install -y libffi-dev && \
    apt-get install -y libssl-dev && \
    apt-get install -y build-essential && \
    pip install -r requirements.txt && \
    apt-get remove -y build-essential && \
    apt-get autoremove -y && \
    rm requirements.txt && \
    apt-get update && \
    apt-get install -y procps && \
    apt-get install -y --no-install-recommends libmagickwand-6.q16-3 fonts-liberation && \
    apt-get clean && \
    rm -rf /var/lib/apt && \
    rm -rf /var/cache/apt && \
    unlink /etc/localtime && ln -s /usr/share/zoneinfo/Europe/Madrid /etc/localtime

COPY main.py insultos.txt insults.txt ./
COPY pytel_bot ./pytel_bot/

CMD python main.py
