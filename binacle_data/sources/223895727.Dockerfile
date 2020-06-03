FROM python:2-alpine
EXPOSE 5000

# Add current folder as /app
ADD . /app
WORKDIR /app

# Install basic utilities
RUN export http_proxy=http://proxy.esl.cisco.com:80/ \
  && export https_proxy=http://proxy.esl.cisco.com:80/ \
  && apk add -U \
        ca-certificates \
  && rm -rf /var/cache/apk/* \
  && pip install --no-cache-dir --requirement ./requirements.txt

ENV http_proxy=http://proxy.esl.cisco.com:80/
ENV https_proxy=http://proxy.esl.cisco.com:80/

CMD [ "python", "./roomfinder_web/web_server.py" ]

