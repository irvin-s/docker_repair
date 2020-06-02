FROM python:2-alpine
EXPOSE 5000

# Add current folder as /app
ADD . /app
WORKDIR /app

# Install basic utilities
RUN apk add -U \
        ca-certificates curl tzdata \
  && rm -rf /var/cache/apk/* \
  && cp /usr/share/zoneinfo/Europe/Paris /etc/localtime \
  && pip install --no-cache-dir --requirement ./requirements.txt

CMD [ "python", "./roomfinder_spark/spark_bot.py" ]

