FROM ubuntu

RUN apt-get update
RUN apt-get install -y curl

COPY ./tests /tests
WORKDIR /tests

CMD ["bash", "test_rest.sh"]