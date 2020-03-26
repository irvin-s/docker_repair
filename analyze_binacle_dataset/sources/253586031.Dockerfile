FROM xuntian/npl-runtime:prod
MAINTAINER zdw "favorofife@yeah.net"

ARG DIST_PKG

# compile qiniu sdk (libboost ver > 1.55)
# install boost in npl image
#RUN apt-get update
#RUN apt-get install -y libboost-all-dev

ADD ./bin/tini /tini
RUN chmod +x /tini

RUN mkdir -p /project/wikicraft
ADD $DIST_PKG /project/wikicraft/
WORKDIR /project/wikicraft

RUN chmod +x ./lib/qiniu/build/build.sh; sync; ./lib/qiniu/build/build.sh

VOLUME ["/project/wikicraft/database", "/project/wikicraft/log"]

ENTRYPOINT ["/tini", "--", "./ci/serve.sh"]
