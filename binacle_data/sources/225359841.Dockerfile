FROM pubnative/zeppelin:0.7.3

RUN set -ex && \
    buildDeps="${buildDeps} git build-essential" && \
    apt-get update && apt-get install -y --no-install-recommends ${buildDeps} && \
    curl -sL http://archive.apache.org/dist/maven/maven-3/3.5.0/binaries/apache-maven-3.5.0-bin.tar.gz | gunzip | tar x -C /tmp/ && \
    curl -sL https://cmake.org/files/v3.8/cmake-3.8.2-Linux-x86_64.tar.gz | gunzip | tar x -C /tmp/ && \
    ln -s /tmp/cmake-3.8.2-Linux-x86_64/bin/cmake /usr/bin/cmake && \
    git clone --recursive https://github.com/dmlc/xgboost /usr/src/xgboost && \
    cd /usr/src/xgboost && \
    cd ./jvm-packages && \
    MAVEN_OPTS="-Xmx2g -XX:MaxPermSize=1024m" /tmp/apache-maven-3.5.0/bin/mvn install -DskipTests -pl !xgboost4j-flink,!xgboost4j-example && \
    cp ./xgboost4j/target/xgboost4j-0.7.jar $ZEPPELIN_HOME/lib && \
    cp ./xgboost4j-spark/target/xgboost4j-spark-0.7.jar $ZEPPELIN_HOME/lib