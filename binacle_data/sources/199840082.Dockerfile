FROM google/golang:1.4

RUN cd /goroot/src/ && GOOS=linux GOARCH=386 ./make.bash --no-clean

RUN apt-get update && apt-get install ruby vim-common -y

# Install Java for middleware testing
RUN echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee /etc/apt/sources.list.d/webupd8team-java.list
RUN echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886
RUN apt-get update -y
RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get install oracle-java8-installer -y

RUN wget http://apache-mirror.rbc.ru/pub/apache//commons/io/binaries/commons-io-2.4-bin.tar.gz -P /tmp
RUN tar xzf /tmp/commons-io-2.4-bin.tar.gz -C /tmp

WORKDIR /gopath/src/github.com/buger/gor/
ADD . /gopath/src/github.com/buger/gor/

RUN javac -cp /tmp/commons-io-2.4/commons-io-2.4.jar ./examples/middleware/echo.java

RUN apt-get install graphviz -y

RUN go get -u github.com/golang/lint/golint
RUN go get