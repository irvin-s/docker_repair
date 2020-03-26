
# ベースとするImage
FROM nginx

# Docker Hubにアップロードした際などに使われる
MAINTAINER Naoto Kato <naoto.kato@plaid.co.jp>

# この辺は明示しておいたほうがわかりやすいと思う
USER root
WORKDIR /usr/share/nginx/html/

# viが使えるようにする
RUN \
  apt-get update \
  && apt-get install -y vim \
  && apt-get clean \
  && echo set encoding=utf-8 > /root/.vimrc

# nginxのルートとして置く
COPY root-index.html ./index.html

# volume上に配置する
COPY volume-index.html ./volume/index.html

# ENTRYPOINTの指定がない場合、ベースのImageで指定されているENTRYPOINTが使われる
# ENTRYPOINT ["/entrypoint.sh"]