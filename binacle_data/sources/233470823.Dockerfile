FROM openjdk:8 as builder
RUN git clone https://github.com/cloudfoundry-incubator/credhub
RUN cd credhub && ./gradlew downloadBouncyCastleFips assemble

FROM openjdk:8
RUN apt-get update
RUN apt-get install -y gcc
RUN wget https://dl.google.com/go/go1.12.2.linux-amd64.tar.gz
RUN tar -xvf go1.12.2.linux-amd64.tar.gz
RUN mv go /usr/local
ENV GOROOT=/usr/local/go
ENV PATH=$PATH:/usr/local/go/bin:~/go/bin

RUN go get github.com/onsi/ginkgo/ginkgo
COPY --from=builder /root/.gradle/ /root/.gradle/