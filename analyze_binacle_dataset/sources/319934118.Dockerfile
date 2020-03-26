FROM mariadb/server:10.3

# install test dependencies
RUN apt-get update && apt-get install -y mariadb-test curl python3 python3-pip && pip3 install kubernetes mysql-connector

# install sysbench
RUN curl -s https://packagecloud.io/install/repositories/akopytov/sysbench/script.deb.sh | bash
RUN apt-get install -y sysbench

# copy test suites and scripts
COPY ./test-suite /usr/share/mysql/mysql-test/suite/bookstore
COPY ./infrastructure ./infrastructure
COPY ./run-*.sh ./

# run test case
ENTRYPOINT ["/bin/bash", "./run-tests.sh"]
