FROM lsiobase/ubuntu:xenial

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="zaggash <zaggash@users.noreply.github.com>,sparklyballs"

# package versions
ARG MONGO_VERSION="3.2.9"

# environment settings
ARG DEBIAN_FRONTEND="noninteractive"
ARG COPIED_APP_PATH="/tmp/git-app"
ARG BUNDLE_DIR="/tmp/bundle-dir"

RUN \
 echo "**** install packages ****" && \
 apt-get update && \
 apt-get install -y \
	curl && \
 echo "***** install nodejs ****" && \
 curl -sL \
	https://deb.nodesource.com/setup_0.10 | bash - && \
 apt-get install -y \
	--no-install-recommends \
	nodejs=0.10.48-1nodesource1~xenial1 && \
 echo "**** install mongo ****" && \
 curl -o \
 /tmp/mongo.tgz -L \
	https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-ubuntu1604-$MONGO_VERSION.tgz  && \
 mkdir -p \
	/tmp/mongo_app && \
 tar xf \
 /tmp/mongo.tgz -C \
	/tmp/mongo_app --strip-components=1 && \
 mv /tmp/mongo_app/bin/mongod /usr/bin/ && \
 echo "**** install plexrequests ****" && \
 plexreq_tag=$(curl -sX GET "https://api.github.com/repos/lokenx/plexrequests-meteor/releases/latest" \
	| awk '/tag_name/{print $4;exit}' FS='[""]') && \
 curl -o \
 /tmp/source.tar.gz -L \
	"https://github.com/lokenx/plexrequests-meteor/archive/${plexreq_tag}.tar.gz" && \
 mkdir -p \
	$COPIED_APP_PATH && \
 tar xf \
 /tmp/source.tar.gz -C \
	$COPIED_APP_PATH --strip-components=1 && \
 cd $COPIED_APP_PATH && \
 HOME=/tmp \
 export METEOR_NO_RELEASE_CHECK=true && \
 curl -sL \
	https://install.meteor.com/?release=1.4.1.3 | \
	sed s/--progress-bar/-sL/g | /bin/sh && \
 HOME=/tmp \
 meteor build \
	--directory $BUNDLE_DIR \
	--server=http://localhost:3000 && \
 cd $BUNDLE_DIR/bundle/programs/server/ && \
 npm i && \
 mv $BUNDLE_DIR/bundle /app && \
 echo "**** cleanup ****" && \
 npm cache clear > /dev/null 2>&1 && \
 apt-get clean && \
 rm -rf \
	/tmp/* \
	/tmp/.??* \
	/usr/local/bin/meteor \
	/usr/share/doc \
	/usr/share/doc-base \
	/root/.meteor \
	/var/lib/apt/lists/* \
	/var/tmp/*

# add local files
COPY root/ /

# ports and volumes
EXPOSE 3000
VOLUME /config
