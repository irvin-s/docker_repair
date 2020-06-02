FROM ubuntu:16.04

# BASE 
RUN useradd -ms /bin/bash ubuntu
RUN apt update && apt -y install software-properties-common apt-utils curl apt-transport-https
RUN apt-add-repository -y ppa:ethereum/ethereum
RUN apt-get update && apt-get install -y ethereum && rm -rf /var/lib/apt/lists/*

# GETH
RUN mkdir -p /vol/geth
RUN mkdir -p /vol/logs
RUN mkdir -p /vol/data/geth
RUN chown ubuntu /vol/logs
RUN chown ubuntu /vol/geth
RUN chown ubuntu /vol/data
RUN chown ubuntu /vol/data/geth
RUN mkdir -p /app
USER ubuntu
ADD static-nodes.json /vol/data/geth/static-nodes.json
ADD . app
WORKDIR /app

CMD ["/app/geth.sh"]
