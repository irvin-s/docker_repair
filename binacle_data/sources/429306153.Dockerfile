FROM ruby:2.5.0-alpine

ENV APP_ROOT='/src/github.com/takuti/twitter-bot'

ADD . ${APP_ROOT}
WORKDIR ${APP_ROOT}

RUN apk update && \
  apk add --no-cache --virtual .builddeps ca-certificates wget openjdk7-jre build-base libxml2-dev libxslt-dev && \
  update-ca-certificates && \
  wget 'http://osdn.jp/frs/redir.php?m=jaist&f=%2Figo%2F52344%2Figo-0.4.3.jar' -O igo.jar && \
  wget 'https://drive.google.com/uc?export=download&id=0B4y35FiV1wh7MWVlSDBCSXZMTXM' -O mecab-ipadic.tar.gz && \
  tar zxfv mecab-ipadic.tar.gz && \
  java -cp igo.jar net.reduls.igo.bin.BuildDic ipadic mecab-ipadic-2.7.0-20070801 EUC-JP && \
  rm -rf igo.jar mecab-ipadic-2.7.0-20070801 mecab-ipadic.tar.gz && \
  bundle install && \
  apk del .builddeps

CMD ["bundle", "exec", "foreman", "start"]
