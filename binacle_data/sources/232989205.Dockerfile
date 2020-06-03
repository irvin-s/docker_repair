FROM mosop/crystal-test:latest

RUN apt-get update
RUN apt-get install -y --force-yes crystal
ENV PATH /opt/crystal/bin:$PATH

RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

VOLUME ["/app", "/app/lib", "/root/.ssh"]
WORKDIR /app
