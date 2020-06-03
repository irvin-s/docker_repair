
# ベースとするImage
FROM ubuntu

# Docker Hubにアップロードした際などに使われる
MAINTAINER Naoto Kato <naoto.kato@plaid.co.jp>

# この辺は明示しておいたほうがわかりやすいと思う
USER root
WORKDIR /root/

# 環境変数の定義
ENV MESSAGE_PREFIX "test"

# 一つのRUNが一つのレイヤーになるので、掃除まで一括でおこなう事が多い
RUN \
  apt-get update \
  && apt-get install -y vim \
#  && apt-get install -y mongodb-clients jq \
  && apt-get clean

# 簡単なファイルをつくる
RUN \
  echo 'message!' > message.txt

# entrypointのシェルスクリプトをホストからコピーして埋め込む
COPY entrypoint.sh /entrypoint.sh


# ルートプロセスになる最初の実行対象
# シェルスクリプトを書いて中でexecするパターンがよく使われる
ENTRYPOINT ["/entrypoint.sh"]