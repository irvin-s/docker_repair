FROM y12docker/kotlin-gradle:3.3
RUN apt-get update ; apt-get install -y openjfx curl jq \
    && git clone --depth=1 https://github.com/corda/corda /corda
WORKDIR /corda
RUN ./gradlew wrapper --gradle-version 2.10
RUN ./gradlew build --info
