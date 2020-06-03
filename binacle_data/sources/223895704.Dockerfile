FROM python:2-alpine
EXPOSE 5000

# Add current folder as /app
ADD . /app
WORKDIR /app

# Install basic utilities
RUN apk add -U \
        ca-certificates \
  && rm -rf /var/cache/apk/* \
  && pip install --no-cache-dir --requirement ./requirements.txt

CMD [ "python", "./roomfinder_dispo/dispo.py" ]

