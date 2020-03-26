FROM clojure
MAINTAINER Akvo Foundation <devops@akvo.org>

WORKDIR /usr/src/app
RUN git clone https://github.com/akvo/akvo-reflow.git && \
    cd akvo-reflow && \
    git checkout master && \
    lein deps && \
    lein uberjar && \
    mv target/uberjar/akvo-reflow.jar ../../akvo-reflow.jar && \
    rm -rf ~/.m2

CMD ["java", "-jar", "akvo-reflow.jar"]
