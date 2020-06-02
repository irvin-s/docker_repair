FROM ubuntu:14.04

COPY simulateTests.sh /usr/local/bin/simulateTests

CMD ["simulateTests"]
