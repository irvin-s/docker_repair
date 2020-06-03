FROM ubuntu:16.04

RUN apt-get update && apt-get upgrade -y
RUN apt-get install libssl1.0.0

COPY src/ /opt

WORKDIR "/opt"
CMD ["./game_server"]
