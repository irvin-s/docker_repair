FROM python:3.6

RUN apt-get update && apt-get install -y \
  vim \
  awscli \
  twine \
  jq

ENV PATH="${PATH}:/root/.local/bin/"

WORKDIR /aws-amicleaner
ADD . .
RUN python setup.py install
CMD bash
