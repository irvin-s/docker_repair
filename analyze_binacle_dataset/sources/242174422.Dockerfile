FROM python:3.6-alpine

RUN pip install \
  "kubernetes==1.0.0b1" \
  "jinja2~=2.9.5" \
  "pyyaml~=3.12" \
  "click~=6.7"

WORKDIR /usr/src/app
COPY . /usr/src/app

CMD ["python", "./opy.py"]
