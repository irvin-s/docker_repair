# Dockerfile for htsnexus server on Elastic Beanstalk
FROM ubuntu:trusty
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends --no-install-suggests make xz-utils curl ca-certificates python-pip pigz
RUN pip install awscli
RUN mkdir /app
COPY . /app
WORKDIR /app/
RUN make && make test
EXPOSE 48444
ENTRYPOINT ["/app/eb_startup.sh"]
