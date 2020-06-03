FROM ubuntu:14.04
RUN mkdir /youtrack-data && touch /youtrack-data/.keep
VOLUME /youtrack-data

CMD echo "Pure data container"
