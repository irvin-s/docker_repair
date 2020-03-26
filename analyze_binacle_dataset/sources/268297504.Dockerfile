FROM openjdk:8
ADD ./build/distributions/pq-messenger.tar /usr/src/
COPY ./keys /usr/src/pq-messenger/keys

WORKDIR /usr/src/pq-messenger
CMD ["./bin/pq-messenger", "start", "-keysdir", "./keys"]

