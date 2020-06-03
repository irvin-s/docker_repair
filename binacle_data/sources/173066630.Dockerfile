FROM codequants/bitmex-client:base

ENV MODULE_NAME bitmex-client

COPY . /src

WORKDIR /src


RUN pip install --upgrade pip setuptools && \
    pip install -r requirements.txt -r requirements-test.txt

RUN nosetests
