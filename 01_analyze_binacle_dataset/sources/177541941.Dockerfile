FROM raintank/nodejs

RUN curl -SL https://storage.googleapis.com/golang/go1.7rc1.linux-amd64.tar.gz \
    | tar -xzC /usr/local

COPY wait.sh /usr/local/bin/wait.sh