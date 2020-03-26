FROM ubuntu:16.04

RUN apt-get update && apt-get install -y \
  build-essential \
  python3-pip

RUN pip3 install -U xgboost \
    scikit-learn

RUN apt-get install -y git \
    && git clone https://github.com/znly/go-ml-transpiler.git \
    && cd go-ml-transpiler && pip3 install --user -e .

COPY model/transpile.py /transpiler/python/

RUN mkdir /transpiler/model

RUN python3 /transpiler/python/transpile.py --export-dir=/transpiler/model
