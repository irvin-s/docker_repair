FROM ubuntu:16.04
WORKDIR /var/edublocks
EXPOSE 8081
RUN apt-get update && \
    apt-get install -y curl python python3 python3-pip build-essential && \
    curl -sL https://deb.nodesource.com/setup_6.x | bash - && \
    apt-get update && \
    apt-get install -y nodejs && \
    npm -g i yarn node-gyp && \
    pip3 install 'ipython==6.0.0'

CMD [ "./tools/dev-start.sh" ]
