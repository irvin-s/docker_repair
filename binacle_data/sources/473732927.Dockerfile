# Start from a Debian image.
FROM yardstickbenchmarks/yardstick-env-aws

# Prepare work directory.
RUN mkdir /home/benchmark

WORKDIR /home/benchmark

ADD benchmark-load.sh ./

RUN chmod +x benchmark-load.sh

ADD ./benchmark-result-upload.sh ./

RUN chmod +x benchmark-result-upload.sh

ADD benchmark-s3-init.sh ./

RUN chmod +x benchmark-s3-init.sh

ADD benchmark-user-data.sh ./

RUN chmod +x benchmark-user-data.sh

ADD benchmark-wait.sh ./

RUN chmod +x benchmark-wait.sh

# Run hazelcast server.
ENTRYPOINT \
  AWS_ACCESS_KEY=$(./benchmark-user-data.sh AWS_ACCESS_KEY) \
  AWS_SECRET_KEY=$(./benchmark-user-data.sh AWS_SECRET_KEY) \
  ES3_BUCKET=$(./benchmark-user-data.sh ES3_BUCKET) \
  ./benchmark-s3-init.sh && \
  GIT_REPO=$(./benchmark-user-data.sh GIT_REPO) \
  GIT_BRANCH=$(./benchmark-user-data.sh GIT_BRANCH) \
  ./benchmark-load.sh && \
  cd $(ls -d */) && \
  LOCAL_IP=$(ip addr show dev eth0 | sed -nr 's/.*inet ([^ ]+)\/.*/\1/p') \
  SPARK_LOCAL_IP=$(ip addr show dev eth0 | sed -nr 's/.*inet ([^ ]+)\/.*/\1/p') \
  AWS_ACCESS_KEY=$(../benchmark-user-data.sh AWS_ACCESS_KEY) \
  AWS_SECRET_KEY=$(../benchmark-user-data.sh AWS_SECRET_KEY) \
  bin/benchmark-manual-drivers-start.sh config/benchmark-ec2.properties && \
  ../benchmark-result-upload.sh && \
  ../benchmark-wait.sh