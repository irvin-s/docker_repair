FROM clarkzjw/restweb
MAINTAINER clarkzjw <clarkzjw@gmail.com>

RUN \
  go get github.com/djimenez/iconv-go && \
  git clone https://github.com/ZJGSU-Open-Source/GoOnlineJudge.git $GOPATH/src/GoOnlineJudge

ENV OJ_HOME $GOPATH/src
ENV DATA_PATH=$OJ_HOME/Data
ENV LOG_PATH=$OJ_HOME/log
ENV RUN_PATH=$OJ_HOME/run

RUN \
  mkdir -p $OJ_HOME/Data && \
  mkdir -p $OJ_HOME/DBData && \
  mkdir -p $OJ_HOME/run && \
  mkdir -p $OJ_HOME/log

RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y build-essential flex openjdk-7-jdk && \
  apt-get autoremove && \
  apt-get autoclean && \
  rm -rf /var/lib/apt/lists/*

RUN \
  git clone https://github.com/ZJGSU-Open-Source/RunServer.git $GOPATH/src/RunServer && \
  git clone https://github.com/ZJGSU-Open-Source/vjudger.git $GOPATH/src/vjudger && \
  cd $GOPATH/src/RunServer && \
  ./make.sh

EXPOSE 8888
CMD RunServer
