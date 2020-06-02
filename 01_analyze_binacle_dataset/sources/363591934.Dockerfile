FROM python:3.6.1-alpine

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# install the application locally
COPY . /usr/src/app
RUN python setup.py install

CMD ["shpkpr"]
