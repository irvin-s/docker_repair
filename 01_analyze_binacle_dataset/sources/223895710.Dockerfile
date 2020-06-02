FROM python:2-alpine

# Add current folder as /app
ADD . /app
WORKDIR /app

# Install basic utilities
RUN export http_proxy=http://proxy.esl.cisco.com:80/ \
  && export https_proxy=http://proxy.esl.cisco.com:80/ \ 
  && apk add -U ca-certificates curl tzdata \
#        openssl-dev build-base heimdal-libs \
  && rm -rf /var/cache/apk/* \
  && pip install --no-cache-dir --requirement ./requirements.txt

CMD [ "./roomfinder_router/router.sh" ]
