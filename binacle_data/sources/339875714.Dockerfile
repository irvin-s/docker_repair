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
  cd $GOPATH/src && \
  restweb build GoOnlineJudge

WORKDIR $GOPATH/src
EXPOSE 8080
CMD "restweb" "run" "GoOnlineJudge"
