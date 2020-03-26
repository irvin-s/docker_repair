FROM python:3-alpine

COPY . /nemesis
WORKDIR /nemesis

RUN set -ex \
 && pip install -e . \
 && rm -rf /root/.cache

RUN sed -i -- 's/host=localhost/host=mongodb/g' nemesis.cfg

CMD ["nemesis_bot", "--conf", "nemesis.cfg"]
