FROM python:2-alpine
EXPOSE 5001

# Add current folder as /app
ADD . /app
WORKDIR /app

# Install basic utilities
RUN apk add -U \
        ca-certificates \
  && rm -rf /var/cache/apk/* \
  && pip install --no-cache-dir --requirement ./requirements.txt

# This is failing for some odd pip upgrade error commenting out for now
#RUN pip install --upgrade pip

CMD [ "python", "./roomfinder_data/data_server.py" ]

