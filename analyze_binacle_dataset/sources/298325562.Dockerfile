FROM python:3.5.3
MAINTAINER furion <_@furion.me>

COPY . /src
WORKDIR /src

RUN pip install git+git://github.com/Netherdrake/steem-python.git
RUN make install

CMD ["conductor", "dockertest"]
