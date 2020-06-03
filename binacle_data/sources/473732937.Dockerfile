# Start from a Debian image.
FROM yardstickbenchmarks/yardstick-env

# Prepare work directory.
RUN mkdir /home/benchmark

WORKDIR /home/benchmark

ADD benchmark-load.sh ./

RUN chmod +x benchmark-load.sh

ADD benchmark-result-upload.sh ./

RUN chmod +x benchmark-result-upload.sh

ADD benchmark-wait.sh ./

RUN chmod +x benchmark-wait.sh

# Run yardstick server.
ENTRYPOINT \
  ./benchmark-load.sh && \
  cd $(ls -d */) && \
  bin/benchmark-manual-drivers-start.sh && \
  ../benchmark-result-upload.sh && \
  ../benchmark-wait.sh
