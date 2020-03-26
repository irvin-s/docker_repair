FROM ncc0706/alpine-sshd

MAINTAINER niuyuxian <"ncc0706@gmail.com">

WORKDIR /app

ENV TARGET_DIR /app/java

COPY supervisord.conf /etc/supervisord.conf

RUN apk --update add ca-certificates wget \  
	&& update-ca-certificates \
	&& cd /app \
	&& wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u131-linux-x64.tar.gz \
	&& tar -zxvf jdk-8u131-linux-x64.tar.gz \
	&& ln -s /app/jdk1.8.0_131 $TARGET_DIR \
	&& rm -rf jdk-8u131-linux-x64.tar.gz \
		$TARGET_DIR/*src.zip \
		$TARGET_DIR/lib/missioncontrol \
		$TARGET_DIR/lib/visualvm \
		$TARGET_DIR/lib/*javafx* \
		$TARGET_DIR/jre/plugin \
		$TARGET_DIR/jre/bin/javaws \
		$TARGET_DIR/jre/bin/jjs \
		$TARGET_DIR/jre/bin/orbd \
		$TARGET_DIR/jre/bin/pack200 \
		$TARGET_DIR/jre/bin/policytool \
		$TARGET_DIR/jre/bin/rmid \
		$TARGET_DIR/jre/bin/rmiregistry \
		$TARGET_DIR/jre/bin/servertool \
		$TARGET_DIR/jre/bin/tnameserv \
		$TARGET_DIR/jre/bin/unpack200 \
		$TARGET_DIR/jre/lib/javaws.jar \
		$TARGET_DIR/jre/lib/deploy* \
		$TARGET_DIR/jre/lib/desktop \
		$TARGET_DIR/jre/lib/*javafx* \
		$TARGET_DIR/jre/lib/*jfx* \
		$TARGET_DIR/jre/lib/amd64/libdecora_sse.so \
		$TARGET_DIR/jre/lib/amd64/libprism_*.so \
		$TARGET_DIR/jre/lib/amd64/libfxplugins.so \
		$TARGET_DIR/jre/lib/amd64/libglass.so \
		$TARGET_DIR/jre/lib/amd64/libgstreamer-lite.so \
		$TARGET_DIR/jre/lib/amd64/libjavafx*.so \
		$TARGET_DIR/jre/lib/amd64/libjfx*.so \
		$TARGET_DIR/jre/lib/ext/jfxrt.jar \
		$TARGET_DIR/jre/lib/ext/nashorn.jar \
		$TARGET_DIR/jre/lib/oblique-fonts \
		$TARGET_DIR/jre/lib/plugin.jar \
	        /var/cache/apk/* /tmp/*

# Set environment
ENV JAVA_HOME /app/java
ENV PATH ${PATH}:${JAVA_HOME}/bin



ENTRYPOINT ["/usr/bin/supervisord"]









