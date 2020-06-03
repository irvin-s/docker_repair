FROM perrorone/spiderman:latest
RUN apk add gcc musl-dev libxslt-dev libffi-dev build-base make linux-headers openssl-dev
WORKDIR /SpiderMan
ADD . /SpiderMan
RUN python setup.py install
CMD ["SpiderMan", "init"]
