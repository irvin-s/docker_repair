FROM frictionlessdata/datapackage-pipelines:latest

RUN apk add --update postgresql-client

ADD . /app

WORKDIR /app
RUN pip install .

WORKDIR /app/projects

CMD ["server"]
