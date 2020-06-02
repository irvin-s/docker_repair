FROM solsson/kafka:0.11.0.0

COPY worker.properties ./config/
COPY connect-files.sh ./bin/

ENV FILES_LIST_CMD="find /logs/ -name *.log"

# Set up some sample logs
RUN mkdir /logs/; \
  echo "Mount /logs and/or change FILES_LIST_CMD (currently '$FILES_LIST_CMD') to read real content instead" > /logs/samplefile1.log;

ENTRYPOINT ["./bin/connect-files.sh"]
