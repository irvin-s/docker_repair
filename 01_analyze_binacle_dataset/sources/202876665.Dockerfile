FROM debian:latest

RUN apt-get update && \
    apt-get install -y python python-pip curl netcat && \
    pip install awscli && \
    curl -o /bin/docker https://get.docker.com/builds/Linux/x86_64/docker-latest && \
    chmod a+x /bin/docker && \
    apt-get remove -y curl
COPY ./bench.sh /bench.sh
CMD /bench.sh
