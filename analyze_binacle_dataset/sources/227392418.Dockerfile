FROM pagarme/docker-nodejs:8.9

ADD . /sqs-quooler
WORKDIR /sqs-quooler

RUN npm install
