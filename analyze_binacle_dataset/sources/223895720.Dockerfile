FROM python:2-alpine

# Add current folder as /app
ADD . /app
WORKDIR /app

# Install basic utilities
RUN export http_proxy=http://proxy.esl.cisco.com:80/ \
  && export https_proxy=http://proxy.esl.cisco.com:80/ \
  && apk add -U \
        ca-certificates curl tzdata \
  && rm -rf /var/cache/apk/* \
  && cp /usr/share/zoneinfo/Europe/Paris /etc/localtime \
  && pip install --no-cache-dir --requirement ./requirements.txt

# This is failing for some odd pip upgrade error commenting out for now
#RUN pip install --upgrade pip

ENV http_proxy=http://proxy.esl.cisco.com:80
ENV https_proxy=http://proxy.esl.cisco.com:80
ENV no_proxy=mail.cisco.com

CMD [ "./roomfinder_update/update_server.sh" ]
